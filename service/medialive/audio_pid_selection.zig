/// Audio Pid Selection
pub const AudioPidSelection = struct {
    /// Selects a specific PID from within a source.
    pid: i32,

    pub const json_field_names = .{
        .pid = "Pid",
    };
};
