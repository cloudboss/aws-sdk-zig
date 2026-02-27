pub const ImageFormat = enum {
    png,
    jpeg,
    gif,
    webp,

    pub const json_field_names = .{
        .png = "PNG",
        .jpeg = "JPEG",
        .gif = "GIF",
        .webp = "WEBP",
    };
};
