pub const LicenseStatus = enum {
    available,
    pending_available,
    deactivated,
    suspended,
    expired,
    pending_delete,
    deleted,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .pending_available = "PENDING_AVAILABLE",
        .deactivated = "DEACTIVATED",
        .suspended = "SUSPENDED",
        .expired = "EXPIRED",
        .pending_delete = "PENDING_DELETE",
        .deleted = "DELETED",
    };
};
