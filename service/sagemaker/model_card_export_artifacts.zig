/// The artifacts of the model card export job.
pub const ModelCardExportArtifacts = struct {
    /// The Amazon S3 URI of the exported model artifacts.
    s3_export_artifacts: []const u8,

    pub const json_field_names = .{
        .s3_export_artifacts = "S3ExportArtifacts",
    };
};
