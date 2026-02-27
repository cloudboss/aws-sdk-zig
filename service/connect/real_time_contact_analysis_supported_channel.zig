pub const RealTimeContactAnalysisSupportedChannel = enum {
    voice,
    chat,

    pub const json_field_names = .{
        .voice = "VOICE",
        .chat = "CHAT",
    };
};
