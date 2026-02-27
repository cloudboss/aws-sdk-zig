pub const CertificateStatus = enum {
    active,
    inactive,
    revoked,
    pending_transfer,
    register_inactive,
    pending_activation,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .inactive = "INACTIVE",
        .revoked = "REVOKED",
        .pending_transfer = "PENDING_TRANSFER",
        .register_inactive = "REGISTER_INACTIVE",
        .pending_activation = "PENDING_ACTIVATION",
    };
};
