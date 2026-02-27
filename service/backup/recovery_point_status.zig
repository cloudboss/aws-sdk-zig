pub const RecoveryPointStatus = enum {
    completed,
    partial,
    deleting,
    expired,
    available,
    stopped,
    creating,

    pub const json_field_names = .{
        .completed = "COMPLETED",
        .partial = "PARTIAL",
        .deleting = "DELETING",
        .expired = "EXPIRED",
        .available = "AVAILABLE",
        .stopped = "STOPPED",
        .creating = "CREATING",
    };
};
