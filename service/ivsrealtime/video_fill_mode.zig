pub const VideoFillMode = enum {
    fill,
    cover,
    contain,

    pub const json_field_names = .{
        .fill = "FILL",
        .cover = "COVER",
        .contain = "CONTAIN",
    };
};
