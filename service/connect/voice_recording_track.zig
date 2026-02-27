pub const VoiceRecordingTrack = enum {
    from_agent,
    to_agent,
    all,

    pub const json_field_names = .{
        .from_agent = "FROM_AGENT",
        .to_agent = "TO_AGENT",
        .all = "ALL",
    };
};
