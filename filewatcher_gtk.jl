using FileWatching, Gtk

function show_file_notification(filename)
    # Run GTK operations in main thread
    Gtk.@idle_add begin
        win = GtkWindow("New File Detected")
        set_gtk_property!(win, :default_width, 300)
        set_gtk_property!(win, :default_height, 100)
        
        vbox = GtkBox(:v)
        set_gtk_property!(vbox, :spacing, 10)
        set_gtk_property!(vbox, :margin, 10)
        
        label = GtkLabel("New file detected:\n$filename")
        close_btn = GtkButton("OK")

        push!(vbox, label)
        push!(vbox, close_btn)
        push!(win, vbox)

        signal_connect(close_btn, "clicked") do widget
            destroy(win)
        end

        showall(win)
    end
end

function watch_files_with_popup(dir=".")
    # Watch directory in background
    @async begin
        try
            while true
                try
                    file, event = watch_folder(dir)
                    if event == :created
                        show_file_notification(file)
                    end
                catch e
                    if !(e isa InterruptException)
                        @warn "Error watching folder" exception=e
                    else
                        rethrow()
                    end
                end
                yield()
            end
        catch e
            if e isa InterruptException
                @info "File watching stopped"
            else
                @error "Fatal error in file watching" exception=e
            end
        end
    end

    # Start GTK main loop
    if !isinteractive()
        @async Gtk.main()
    end
    nothing
end

# Start watching current directory
if !isinteractive()
    watch_files_with_popup()
end