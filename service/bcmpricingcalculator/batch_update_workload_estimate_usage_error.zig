const WorkloadEstimateUpdateUsageErrorCode = @import("workload_estimate_update_usage_error_code.zig").WorkloadEstimateUpdateUsageErrorCode;

/// Represents an error that occurred when updating usage in a workload
/// estimate.
pub const BatchUpdateWorkloadEstimateUsageError = struct {
    /// The code associated with the error.
    error_code: ?WorkloadEstimateUpdateUsageErrorCode = null,

    /// The message that describes the error.
    error_message: ?[]const u8 = null,

    /// The ID of the error.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .id = "id",
    };
};
