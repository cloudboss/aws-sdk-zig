const ModelImportJobStatus = @import("model_import_job_status.zig").ModelImportJobStatus;

/// Information about the import job.
pub const ModelImportJobSummary = struct {
    /// The time import job was created.
    creation_time: i64,

    /// The time when import job ended.
    end_time: ?i64,

    /// The Amazon resource Name (ARN) of the imported model.
    imported_model_arn: ?[]const u8,

    /// The name of the imported model.
    imported_model_name: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the import job.
    job_arn: []const u8,

    /// The name of the import job.
    job_name: []const u8,

    /// The time when the import job was last modified.
    last_modified_time: ?i64,

    /// The status of the imported job.
    status: ModelImportJobStatus,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .end_time = "endTime",
        .imported_model_arn = "importedModelArn",
        .imported_model_name = "importedModelName",
        .job_arn = "jobArn",
        .job_name = "jobName",
        .last_modified_time = "lastModifiedTime",
        .status = "status",
    };
};
