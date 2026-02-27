pub const RouterOutputProtocol = enum {
    rtp,
    rist,
    srt_caller,
    srt_listener,

    pub const json_field_names = .{
        .rtp = "RTP",
        .rist = "RIST",
        .srt_caller = "SRT_CALLER",
        .srt_listener = "SRT_LISTENER",
    };
};
