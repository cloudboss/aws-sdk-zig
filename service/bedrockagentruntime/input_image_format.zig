pub const InputImageFormat = enum {
    png,
    jpeg,
    gif,
    webp,

    pub const json_field_names = .{
        .png = "png",
        .jpeg = "jpeg",
        .gif = "gif",
        .webp = "webp",
    };
};
