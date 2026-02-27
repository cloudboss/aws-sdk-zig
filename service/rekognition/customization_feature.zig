pub const CustomizationFeature = enum {
    content_moderation,
    custom_labels,

    pub const json_field_names = .{
        .content_moderation = "CONTENT_MODERATION",
        .custom_labels = "CUSTOM_LABELS",
    };
};
