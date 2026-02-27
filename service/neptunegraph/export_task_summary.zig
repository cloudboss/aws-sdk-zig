const ExportFormat = @import("export_format.zig").ExportFormat;
const ParquetType = @import("parquet_type.zig").ParquetType;
const ExportTaskStatus = @import("export_task_status.zig").ExportTaskStatus;

/// Provides details about an export task.
pub const ExportTaskSummary = struct {
    /// The Amazon S3 URI of the export task where data will be exported to.
    destination: []const u8,

    /// The format of the export task.
    format: ExportFormat,

    /// The source graph identifier of the export task.
    graph_id: []const u8,

    /// The KMS key identifier of the export task.
    kms_key_identifier: []const u8,

    /// The parquet type of the export task.
    parquet_type: ?ParquetType,

    /// The ARN of the IAM role that will allow the data to be exported to the
    /// destination.
    role_arn: []const u8,

    /// The current status of the export task.
    status: ExportTaskStatus,

    /// The reason that the export task has this status value.
    status_reason: ?[]const u8,

    /// The unique identifier of the export task.
    task_id: []const u8,

    pub const json_field_names = .{
        .destination = "destination",
        .format = "format",
        .graph_id = "graphId",
        .kms_key_identifier = "kmsKeyIdentifier",
        .parquet_type = "parquetType",
        .role_arn = "roleArn",
        .status = "status",
        .status_reason = "statusReason",
        .task_id = "taskId",
    };
};
