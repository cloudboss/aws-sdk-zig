const AlgorithmStatus = @import("algorithm_status.zig").AlgorithmStatus;

/// Provides summary information about an algorithm.
pub const AlgorithmSummary = struct {
    /// The Amazon Resource Name (ARN) of the algorithm.
    algorithm_arn: []const u8,

    /// A brief description of the algorithm.
    algorithm_description: ?[]const u8 = null,

    /// The name of the algorithm that is described by the summary.
    algorithm_name: []const u8,

    /// The overall status of the algorithm.
    algorithm_status: AlgorithmStatus,

    /// A timestamp that shows when the algorithm was created.
    creation_time: i64,

    pub const json_field_names = .{
        .algorithm_arn = "AlgorithmArn",
        .algorithm_description = "AlgorithmDescription",
        .algorithm_name = "AlgorithmName",
        .algorithm_status = "AlgorithmStatus",
        .creation_time = "CreationTime",
    };
};
