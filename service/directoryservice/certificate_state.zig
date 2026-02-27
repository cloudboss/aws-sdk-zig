pub const CertificateState = enum {
    registering,
    registered,
    register_failed,
    deregistering,
    deregistered,
    deregister_failed,

    pub const json_field_names = .{
        .registering = "REGISTERING",
        .registered = "REGISTERED",
        .register_failed = "REGISTER_FAILED",
        .deregistering = "DEREGISTERING",
        .deregistered = "DEREGISTERED",
        .deregister_failed = "DEREGISTER_FAILED",
    };
};
