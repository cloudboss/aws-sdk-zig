pub const AudioStandardGenerativeFieldType = enum {
    audio_summary,
    iab,
    topic_summary,

    pub const json_field_names = .{
        .audio_summary = "AUDIO_SUMMARY",
        .iab = "IAB",
        .topic_summary = "TOPIC_SUMMARY",
    };
};
