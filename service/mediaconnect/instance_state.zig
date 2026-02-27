pub const InstanceState = enum {
    registering,
    active,
    deregistering,
    deregistered,
    registration_error,
    deregistration_error,

    pub const json_field_names = .{
        .registering = "REGISTERING",
        .active = "ACTIVE",
        .deregistering = "DEREGISTERING",
        .deregistered = "DEREGISTERED",
        .registration_error = "REGISTRATION_ERROR",
        .deregistration_error = "DEREGISTRATION_ERROR",
    };
};
