pub const ThreatIntelSetStatus = enum {
    inactive,
    activating,
    active,
    deactivating,
    @"error",
    delete_pending,
    deleted,

    pub const json_field_names = .{
        .inactive = "INACTIVE",
        .activating = "ACTIVATING",
        .active = "ACTIVE",
        .deactivating = "DEACTIVATING",
        .@"error" = "ERROR",
        .delete_pending = "DELETE_PENDING",
        .deleted = "DELETED",
    };
};
