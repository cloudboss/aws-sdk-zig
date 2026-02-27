pub const InteractionMode = enum {
    interactive,
    no_video,
    video_only,

    pub const json_field_names = .{
        .interactive = "INTERACTIVE",
        .no_video = "NO_VIDEO",
        .video_only = "VIDEO_ONLY",
    };
};
