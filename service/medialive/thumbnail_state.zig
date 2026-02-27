/// Thumbnail State
pub const ThumbnailState = enum {
    auto,
    disabled,

    pub const json_field_names = .{
        .auto = "AUTO",
        .disabled = "DISABLED",
    };
};
