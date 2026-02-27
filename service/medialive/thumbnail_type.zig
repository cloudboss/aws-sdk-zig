/// Thumbnail type.
pub const ThumbnailType = enum {
    unspecified,
    current_active,

    pub const json_field_names = .{
        .unspecified = "UNSPECIFIED",
        .current_active = "CURRENT_ACTIVE",
    };
};
