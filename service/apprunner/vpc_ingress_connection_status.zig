pub const VpcIngressConnectionStatus = enum {
    available,
    pending_creation,
    pending_update,
    pending_deletion,
    failed_creation,
    failed_update,
    failed_deletion,
    deleted,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .pending_creation = "PENDING_CREATION",
        .pending_update = "PENDING_UPDATE",
        .pending_deletion = "PENDING_DELETION",
        .failed_creation = "FAILED_CREATION",
        .failed_update = "FAILED_UPDATE",
        .failed_deletion = "FAILED_DELETION",
        .deleted = "DELETED",
    };
};
