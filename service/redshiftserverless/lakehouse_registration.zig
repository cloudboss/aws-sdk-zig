pub const LakehouseRegistration = enum {
    register,
    deregister,

    pub const json_field_names = .{
        .register = "REGISTER",
        .deregister = "DEREGISTER",
    };
};
