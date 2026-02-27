pub const RegistrationStatus = enum {
    unregistered,
    registered,
    suspended,

    pub const json_field_names = .{
        .unregistered = "Unregistered",
        .registered = "Registered",
        .suspended = "Suspended",
    };
};
