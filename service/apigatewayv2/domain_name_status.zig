/// The status of the domain name migration. The valid values are AVAILABLE,
/// UPDATING, PENDING_CERTIFICATE_REIMPORT, and PENDING_OWNERSHIP_VERIFICATION.
/// If the status is UPDATING, the domain cannot be modified further until the
/// existing operation is complete. If it is AVAILABLE, the domain can be
/// updated.
pub const DomainNameStatus = enum {
    available,
    updating,
    pending_certificate_reimport,
    pending_ownership_verification,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .updating = "UPDATING",
        .pending_certificate_reimport = "PENDING_CERTIFICATE_REIMPORT",
        .pending_ownership_verification = "PENDING_OWNERSHIP_VERIFICATION",
    };
};
