pub const RegistrationStatus = enum {
    registered,
    deregistered,

    pub const json_field_names = .{
        .registered = "Registered",
        .deregistered = "Deregistered",
    };
};
