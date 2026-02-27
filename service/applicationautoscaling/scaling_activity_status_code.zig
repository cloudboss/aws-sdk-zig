pub const ScalingActivityStatusCode = enum {
    pending,
    in_progress,
    successful,
    overridden,
    unfulfilled,
    failed,

    pub const json_field_names = .{
        .pending = "Pending",
        .in_progress = "InProgress",
        .successful = "Successful",
        .overridden = "Overridden",
        .unfulfilled = "Unfulfilled",
        .failed = "Failed",
    };
};
