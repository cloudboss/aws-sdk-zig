pub const DecalStyleType = enum {
    manual,
    auto,

    pub const json_field_names = .{
        .manual = "Manual",
        .auto = "Auto",
    };
};
