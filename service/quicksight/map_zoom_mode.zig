pub const MapZoomMode = enum {
    auto,
    manual,

    pub const json_field_names = .{
        .auto = "AUTO",
        .manual = "MANUAL",
    };
};
