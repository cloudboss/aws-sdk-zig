/// M2ts Ebp Placement
pub const M2tsEbpPlacement = enum {
    video_and_audio_pids,
    video_pid,

    pub const json_field_names = .{
        .video_and_audio_pids = "VIDEO_AND_AUDIO_PIDS",
        .video_pid = "VIDEO_PID",
    };
};
