const AudioPid = @import("audio_pid.zig").AudioPid;

/// Audio Pid Selection
pub const AudioPidSelection = struct {
    /// Selects a specific PID from within a source.
    pid: i32,

    /// Selects one or more unique PIDs from within a source.
    /// When using 'pids', you can specify per-PID audio pre-mixer settings.
    pids: ?[]const AudioPid = null,

    pub const json_field_names = .{
        .pid = "Pid",
        .pids = "Pids",
    };
};
