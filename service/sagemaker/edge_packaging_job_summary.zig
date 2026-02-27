const EdgePackagingJobStatus = @import("edge_packaging_job_status.zig").EdgePackagingJobStatus;

/// Summary of edge packaging job.
pub const EdgePackagingJobSummary = struct {
    /// The name of the SageMaker Neo compilation job.
    compilation_job_name: ?[]const u8,

    /// The timestamp of when the job was created.
    creation_time: ?i64,

    /// The Amazon Resource Name (ARN) of the edge packaging job.
    edge_packaging_job_arn: []const u8,

    /// The name of the edge packaging job.
    edge_packaging_job_name: []const u8,

    /// The status of the edge packaging job.
    edge_packaging_job_status: EdgePackagingJobStatus,

    /// The timestamp of when the edge packaging job was last updated.
    last_modified_time: ?i64,

    /// The name of the model.
    model_name: ?[]const u8,

    /// The version of the model.
    model_version: ?[]const u8,

    pub const json_field_names = .{
        .compilation_job_name = "CompilationJobName",
        .creation_time = "CreationTime",
        .edge_packaging_job_arn = "EdgePackagingJobArn",
        .edge_packaging_job_name = "EdgePackagingJobName",
        .edge_packaging_job_status = "EdgePackagingJobStatus",
        .last_modified_time = "LastModifiedTime",
        .model_name = "ModelName",
        .model_version = "ModelVersion",
    };
};
