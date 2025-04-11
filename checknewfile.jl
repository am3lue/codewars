# Function to check for new or modified files in current directory
# Uses file modification time for efficient checking with many files
# Returns tuple: (has_changes::Bool, new_or_modified::Vector{String})
function checkNewFiles(last_check_time::Float64=0.0)
    # Get all files in current directory with their stats
    files = readdir()
    file_stats = [(f, stat(f)) for f in files if isfile(f)]
    
    # Filter files modified since last check time
    new_files = String[]
    for (f, s) in file_stats
        # Compare modification time (in seconds since epoch)
        if s.mtime > last_check_time
            push!(new_files, f)
        end
    end
    
    # Return results and current time for next check
    return !isempty(new_files), new_files, time()
end

# Example usage:
# last_check = 0.0  # Initial check (epoch time)
# has_changes, changed_files, new_check_time = checkNewFiles(last_check)
# if has_changes
#     println("New/modified files: ", join(changed_files, ", "))
#     # Store new_check_time for next comparison
# else
#     println("No changes detected")
# end
