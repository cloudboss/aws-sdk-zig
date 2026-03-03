const BatchCreateWorkloadEstimateUsageCode = @import("batch_create_workload_estimate_usage_code.zig").BatchCreateWorkloadEstimateUsageCode;

/// Represents an error that occurred during a batch create operation for
/// workload estimate usage.
pub const BatchCreateWorkloadEstimateUsageError = struct {
    /// The error code associated with the failed operation.
    error_code: ?BatchCreateWorkloadEstimateUsageCode = null,

    /// A descriptive message for the error that occurred.
    error_message: ?[]const u8 = null,

    /// The key of the entry that caused the error.
    key: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .key = "key",
    };
};
