pub const OperationStatus = enum {
    submitted,
    in_progress,
    @"error",
    successful,
    failed,

    pub const json_field_names = .{
        .submitted = "SUBMITTED",
        .in_progress = "IN_PROGRESS",
        .@"error" = "ERROR",
        .successful = "SUCCESSFUL",
        .failed = "FAILED",
    };
};
