pub const OperationStatus = enum {
    not_started,
    started,
    failed,
    completed,
    succeeded,

    pub const json_field_names = .{
        .not_started = "NotStarted",
        .started = "Started",
        .failed = "Failed",
        .completed = "Completed",
        .succeeded = "Succeeded",
    };
};
