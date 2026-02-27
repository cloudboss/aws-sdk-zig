pub const VideoExtractionCategoryType = enum {
    content_moderation,
    text_detection,
    transcript,
    logos,

    pub const json_field_names = .{
        .content_moderation = "CONTENT_MODERATION",
        .text_detection = "TEXT_DETECTION",
        .transcript = "TRANSCRIPT",
        .logos = "LOGOS",
    };
};
