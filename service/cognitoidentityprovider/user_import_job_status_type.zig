pub const UserImportJobStatusType = enum {
    created,
    pending,
    in_progress,
    stopping,
    expired,
    stopped,
    failed,
    succeeded,

    pub const json_field_names = .{
        .created = "Created",
        .pending = "Pending",
        .in_progress = "InProgress",
        .stopping = "Stopping",
        .expired = "Expired",
        .stopped = "Stopped",
        .failed = "Failed",
        .succeeded = "Succeeded",
    };
};
