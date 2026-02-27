pub const RegistrationStatus = enum {
    registered,
    deprecated,

    pub const json_field_names = .{
        .registered = "REGISTERED",
        .deprecated = "DEPRECATED",
    };
};
