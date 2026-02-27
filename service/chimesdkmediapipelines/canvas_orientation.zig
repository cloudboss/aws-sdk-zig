pub const CanvasOrientation = enum {
    landscape,
    portrait,

    pub const json_field_names = .{
        .landscape = "Landscape",
        .portrait = "Portrait",
    };
};
