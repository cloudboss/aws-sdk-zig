pub const BaselineOperationStatus = enum {
    succeeded,
    failed,
    in_progress,

    pub const json_field_names = .{
        .succeeded = "SUCCEEDED",
        .failed = "FAILED",
        .in_progress = "IN_PROGRESS",
    };
};
