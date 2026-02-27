pub const DataRepositoryTaskLifecycle = enum {
    pending,
    executing,
    failed,
    succeeded,
    canceled,
    canceling,

    pub const json_field_names = .{
        .pending = "PENDING",
        .executing = "EXECUTING",
        .failed = "FAILED",
        .succeeded = "SUCCEEDED",
        .canceled = "CANCELED",
        .canceling = "CANCELING",
    };
};
