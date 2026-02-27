pub const Persona = enum {
    admin,
    enduser,

    pub const json_field_names = .{
        .admin = "ADMIN",
        .enduser = "ENDUSER",
    };
};
