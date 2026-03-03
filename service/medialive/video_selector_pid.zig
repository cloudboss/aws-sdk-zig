/// Video Selector Pid
pub const VideoSelectorPid = struct {
    /// Selects a specific PID from within a video source.
    pid: ?i32 = null,

    pub const json_field_names = .{
        .pid = "Pid",
    };
};
