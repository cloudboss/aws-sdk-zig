pub const SigningStatus = enum {
    in_progress,
    failed,
    succeeded,

    pub const json_field_names = .{
        .in_progress = "InProgress",
        .failed = "Failed",
        .succeeded = "Succeeded",
    };
};
