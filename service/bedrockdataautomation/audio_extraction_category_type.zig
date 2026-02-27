pub const AudioExtractionCategoryType = enum {
    audio_content_moderation,
    transcript,
    topic_content_moderation,

    pub const json_field_names = .{
        .audio_content_moderation = "AUDIO_CONTENT_MODERATION",
        .transcript = "TRANSCRIPT",
        .topic_content_moderation = "TOPIC_CONTENT_MODERATION",
    };
};
