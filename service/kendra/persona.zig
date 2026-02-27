pub const Persona = enum {
    owner,
    viewer,

    pub const json_field_names = .{
        .owner = "OWNER",
        .viewer = "VIEWER",
    };
};
