function write_cut_info(state)
    local time = mp.get_property_number("time-pos")
    
    local path = mp.get_property("path")
    
    local file = io.open("/tmp/cut", "a")
    
    if not file then
        mp.msg.error("Could not open /tmp/cut for writing")
        return
    end
    
    file:write(string.format("file: \"%s\"\ntimestamp: %s\nstate: %s\n\n", path, time, state))
    
    file:close()
    
end

function write_cut_begin()
   write_cut_info("begin")
   mp.osd_message("Info of cut begin written to /tmp/cut")
end

function write_cut_end()
   write_cut_info("end")
   mp.osd_message("Info of cut end written to /tmp/cut")
end

mp.add_key_binding("[", "write_cut_begin", write_cut_begin)
mp.add_key_binding("]", "write_cut_end", write_cut_end)
