import re
from collections import defaultdict
import os
import subprocess
import shutil

def parse_log_file(filepath):
    with open(filepath, 'r') as file:
        content = file.read().strip()

    # Splitting the content by two newlines to separate the blocks
    blocks = content.split('\n\n')

    parsed_blocks = []
    for block in blocks:
        # Find the file, timestamp, and state using regular expressions
        file_match = re.search(r'file: "(.*)"', block)
        timestamp_match = re.search(r'timestamp: ([\d.]+)', block)
        state_match = re.search(r'state: (\w+)', block)

        if file_match and timestamp_match and state_match:
            file_path = file_match.group(1)
            timestamp = float(timestamp_match.group(1))
            state = state_match.group(1)
            parsed_blocks.append((file_path, timestamp, state))
    
    return parsed_blocks

def find_begin_end_pairs(blocks):
    # Using defaultdict to handle multiple pairs per video file
    pairs = defaultdict(list)
    temp_pairs = defaultdict(list)

    for file_path, timestamp, state in blocks:
        if state == 'begin':
            temp_pairs[file_path].append((timestamp, None))
        elif state == 'end' and temp_pairs[file_path]:
            # Find the last 'begin' without an 'end' and pair it
            for i, (begin_ts, _) in enumerate(temp_pairs[file_path][::-1]):
                if begin_ts < timestamp:
                    temp_pairs[file_path][-1 - i] = (begin_ts, timestamp)
                    break

    # Removing any incomplete pairs and sorting by the begin timestamp
    for file_path, ts_pairs in temp_pairs.items():
        complete_pairs = [pair for pair in ts_pairs if pair[1] is not None]
        pairs[file_path] = sorted(complete_pairs, key=lambda x: x[0])
    
    return pairs

def cut_videos_with_ffmpeg(pairs):
    for file, timestamp_pairs in pairs.items():
        for seq, (start, end) in enumerate(timestamp_pairs):
            # Prepare output file pattern
            file_name, file_extension = os.path.splitext(file)
            output_file = f"{file_name}.cut.{seq + 1}{file_extension}"
            
            duration = end - start
            
            command = [
                'ffmpeg',
                '-i', f'"{file}"',
                '-ss', str(start),
                '-t', str(duration),
                '-c', 'copy',  
                f'"{output_file}"'
            ]
            
            try:
                print(f"Cutting video: {output_file}")
                subprocess.run(' '.join(command), shell=True, check=True)
            except subprocess.CalledProcessError as e:
                print(f"Failed to cut video {file}: {e}")

        trash_path = os.path.expanduser('~/.Trash')
        try:
            shutil.move(file, trash_path)
            print(f"Moved original file to trash: {file}")
        except Exception as e:
            print(f"Failed to move file to trash: {file}. Error: {e}")

if __name__ == '__main__':
    log_file_path = '/tmp/cut'
    blocks = parse_log_file(log_file_path)
    begin_end_pairs = find_begin_end_pairs(blocks)

    for file, pairs in begin_end_pairs.items():
        print(f'File: {file}')
        for begin, end in pairs:
            print(f'  Begin: {begin} - End: {end}')

    cut_videos_with_ffmpeg(begin_end_pairs)
