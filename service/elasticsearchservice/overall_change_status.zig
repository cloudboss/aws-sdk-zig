/// The overall status value of the domain configuration change.
pub const OverallChangeStatus = enum {
    pending,
    processing,
    completed,
    failed,

    pub const json_field_names = .{
        .pending = "PENDING",
        .processing = "PROCESSING",
        .completed = "COMPLETED",
        .failed = "FAILED",
    };
};
