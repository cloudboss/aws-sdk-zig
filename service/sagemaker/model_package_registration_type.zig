pub const ModelPackageRegistrationType = enum {
    logged,
    registered,

    pub const json_field_names = .{
        .logged = "LOGGED",
        .registered = "REGISTERED",
    };
};
