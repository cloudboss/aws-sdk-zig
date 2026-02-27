pub const ServerCertificateStatus = enum {
    invalid,
    valid,

    pub const json_field_names = .{
        .invalid = "INVALID",
        .valid = "VALID",
    };
};
