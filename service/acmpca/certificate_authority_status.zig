pub const CertificateAuthorityStatus = enum {
    creating,
    pending_certificate,
    active,
    deleted,
    disabled,
    expired,
    failed,

    pub const json_field_names = .{
        .creating = "CREATING",
        .pending_certificate = "PENDING_CERTIFICATE",
        .active = "ACTIVE",
        .deleted = "DELETED",
        .disabled = "DISABLED",
        .expired = "EXPIRED",
        .failed = "FAILED",
    };
};
