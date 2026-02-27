pub const Status = enum {
    /// InProgress status
    in_progress,
    /// Completed status
    completed,
    /// Successful status
    successful,
    /// Failed status
    failed,

    pub const json_field_names = .{
        .in_progress = "InProgress",
        .completed = "Completed",
        .successful = "Successful",
        .failed = "Failed",
    };
};
