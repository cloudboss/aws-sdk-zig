/// Configure the export output details for an Amazon SageMaker Model Card.
pub const ModelCardExportOutputConfig = struct {
    /// The Amazon S3 output path to export your model card PDF.
    s3_output_path: []const u8,

    pub const json_field_names = .{
        .s3_output_path = "S3OutputPath",
    };
};
