pub const BaseMapStyleType = enum {
    light_gray,
    dark_gray,
    street,
    imagery,

    pub const json_field_names = .{
        .light_gray = "LIGHT_GRAY",
        .dark_gray = "DARK_GRAY",
        .street = "STREET",
        .imagery = "IMAGERY",
    };
};
