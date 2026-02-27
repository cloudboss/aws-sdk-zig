pub const Permission = enum {
    administrator,
    viewer,

    pub const json_field_names = .{
        .administrator = "ADMINISTRATOR",
        .viewer = "VIEWER",
    };
};
