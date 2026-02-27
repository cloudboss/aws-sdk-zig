pub const ImageExtractionCategoryType = enum {
    content_moderation,
    text_detection,
    logos,

    pub const json_field_names = .{
        .content_moderation = "CONTENT_MODERATION",
        .text_detection = "TEXT_DETECTION",
        .logos = "LOGOS",
    };
};
