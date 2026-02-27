const ModelCardExportJobStatus = @import("model_card_export_job_status.zig").ModelCardExportJobStatus;

/// The summary of the Amazon SageMaker Model Card export job.
pub const ModelCardExportJobSummary = struct {
    /// The date and time that the model card export job was created.
    created_at: i64,

    /// The date and time that the model card export job was last modified..
    last_modified_at: i64,

    /// The Amazon Resource Name (ARN) of the model card export job.
    model_card_export_job_arn: []const u8,

    /// The name of the model card export job.
    model_card_export_job_name: []const u8,

    /// The name of the model card that the export job exports.
    model_card_name: []const u8,

    /// The version of the model card that the export job exports.
    model_card_version: i32,

    /// The completion status of the model card export job.
    status: ModelCardExportJobStatus,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .last_modified_at = "LastModifiedAt",
        .model_card_export_job_arn = "ModelCardExportJobArn",
        .model_card_export_job_name = "ModelCardExportJobName",
        .model_card_name = "ModelCardName",
        .model_card_version = "ModelCardVersion",
        .status = "Status",
    };
};
