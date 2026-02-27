const aws = @import("aws");

const QuantumTaskStatus = @import("quantum_task_status.zig").QuantumTaskStatus;

/// Includes information about a quantum task.
pub const QuantumTaskSummary = struct {
    /// The time at which the quantum task was created.
    created_at: i64,

    /// The ARN of the device the quantum task ran on.
    device_arn: []const u8,

    /// The time at which the quantum task finished.
    ended_at: ?i64,

    /// The S3 bucket where the quantum task result file is stored.
    output_s3_bucket: []const u8,

    /// The folder in the S3 bucket where the quantum task result file is stored.
    output_s3_directory: []const u8,

    /// The ARN of the quantum task.
    quantum_task_arn: []const u8,

    /// The shots used for the quantum task.
    shots: i64,

    /// The status of the quantum task.
    status: QuantumTaskStatus,

    /// Displays the key, value pairs of tags associated with this quantum task.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .device_arn = "deviceArn",
        .ended_at = "endedAt",
        .output_s3_bucket = "outputS3Bucket",
        .output_s3_directory = "outputS3Directory",
        .quantum_task_arn = "quantumTaskArn",
        .shots = "shots",
        .status = "status",
        .tags = "tags",
    };
};
