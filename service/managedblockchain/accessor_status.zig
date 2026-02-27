pub const AccessorStatus = enum {
    available,
    pending_deletion,
    deleted,

    pub const json_field_names = .{
        .available = "AVAILABLE",
        .pending_deletion = "PENDING_DELETION",
        .deleted = "DELETED",
    };
};
