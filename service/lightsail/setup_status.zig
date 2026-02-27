pub const SetupStatus = enum {
    succeeded,
    failed,
    in_progress,

    pub const json_field_names = .{
        .succeeded = "Succeeded",
        .failed = "Failed",
        .in_progress = "InProgress",
    };
};
