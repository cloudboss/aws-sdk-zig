pub const PaperOrientation = enum {
    portrait,
    landscape,

    pub const json_field_names = .{
        .portrait = "PORTRAIT",
        .landscape = "LANDSCAPE",
    };
};
