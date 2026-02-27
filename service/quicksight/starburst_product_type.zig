pub const StarburstProductType = enum {
    galaxy,
    enterprise,

    pub const json_field_names = .{
        .galaxy = "GALAXY",
        .enterprise = "ENTERPRISE",
    };
};
