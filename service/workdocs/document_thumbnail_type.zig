pub const DocumentThumbnailType = enum {
    small,
    small_hq,
    large,

    pub const json_field_names = .{
        .small = "SMALL",
        .small_hq = "SMALL_HQ",
        .large = "LARGE",
    };
};
