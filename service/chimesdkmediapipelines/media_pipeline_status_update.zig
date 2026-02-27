pub const MediaPipelineStatusUpdate = enum {
    pause,
    @"resume",

    pub const json_field_names = .{
        .pause = "Pause",
        .@"resume" = "Resume",
    };
};
