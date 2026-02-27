/// The status of the operation.
pub const OperationStatus = enum {
    in_progress,
    cancelled,
    successful,
    failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .cancelled = "CANCELLED",
        .successful = "SUCCESSFUL",
        .failed = "FAILED",
    };
};
