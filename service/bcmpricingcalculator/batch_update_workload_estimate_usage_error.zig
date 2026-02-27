const WorkloadEstimateUpdateUsageErrorCode = @import("workload_estimate_update_usage_error_code.zig").WorkloadEstimateUpdateUsageErrorCode;

/// Represents an error that occurred when updating usage in a workload
/// estimate.
pub const BatchUpdateWorkloadEstimateUsageError = struct {
    /// The code associated with the error.
    error_code: ?WorkloadEstimateUpdateUsageErrorCode,

    /// The message that describes the error.
    error_message: ?[]const u8,

    /// The ID of the error.
    id: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .id = "id",
    };
};
