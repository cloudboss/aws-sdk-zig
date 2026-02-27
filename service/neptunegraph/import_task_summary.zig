const Format = @import("format.zig").Format;
const ParquetType = @import("parquet_type.zig").ParquetType;
const ImportTaskStatus = @import("import_task_status.zig").ImportTaskStatus;

/// Details about an import task.
pub const ImportTaskSummary = struct {
    /// Specifies the format of S3 data to be imported. Valid values are `CSV`,
    /// which identifies the [Gremlin CSV
    /// format](https://docs.aws.amazon.com/neptune/latest/userguide/bulk-load-tutorial-format-gremlin.html) or `OPENCYPHER`, which identies the [openCypher load format](https://docs.aws.amazon.com/neptune/latest/userguide/bulk-load-tutorial-format-opencypher.html).
    format: ?Format,

    /// The unique identifier of the Neptune Analytics graph.
    graph_id: ?[]const u8,

    /// The parquet type of the import task.
    parquet_type: ?ParquetType,

    /// The ARN of the IAM role that will allow access to the data that is to be
    /// imported.
    role_arn: []const u8,

    /// A URL identifying to the location of the data to be imported. This can be an
    /// Amazon S3 path, or can point to a Neptune database endpoint or snapshot
    source: []const u8,

    /// Status of the import task.
    status: ImportTaskStatus,

    /// The unique identifier of the import task.
    task_id: []const u8,

    pub const json_field_names = .{
        .format = "format",
        .graph_id = "graphId",
        .parquet_type = "parquetType",
        .role_arn = "roleArn",
        .source = "source",
        .status = "status",
        .task_id = "taskId",
    };
};
