const DetailedAlgorithmStatus = @import("detailed_algorithm_status.zig").DetailedAlgorithmStatus;

/// Represents the overall status of an algorithm.
pub const AlgorithmStatusItem = struct {
    /// if the overall status is `Failed`, the reason for the failure.
    failure_reason: ?[]const u8,

    /// The name of the algorithm for which the overall status is being reported.
    name: []const u8,

    /// The current status.
    status: DetailedAlgorithmStatus,

    pub const json_field_names = .{
        .failure_reason = "FailureReason",
        .name = "Name",
        .status = "Status",
    };
};
