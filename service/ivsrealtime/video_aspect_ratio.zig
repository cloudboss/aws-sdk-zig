pub const VideoAspectRatio = enum {
    auto,
    video,
    square,
    portrait,

    pub const json_field_names = .{
        .auto = "AUTO",
        .video = "VIDEO",
        .square = "SQUARE",
        .portrait = "PORTRAIT",
    };
};
