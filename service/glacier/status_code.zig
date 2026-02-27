pub const StatusCode = enum {
    in_progress,
    succeeded,
    failed,

    pub const json_field_names = .{
        .in_progress = "InProgress",
        .succeeded = "Succeeded",
        .failed = "Failed",
    };
};
