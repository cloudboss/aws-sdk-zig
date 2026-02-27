pub const CertificateStatusType = enum {
    active,
    pending_rotation,
    inactive,

    pub const json_field_names = .{
        .active = "ACTIVE",
        .pending_rotation = "PENDING_ROTATION",
        .inactive = "INACTIVE",
    };
};
