/// Specifies configuration properties for an exporting labels task run.
pub const ExportLabelsTaskRunProperties = struct {
    /// The Amazon Simple Storage Service (Amazon S3) path where you will export the
    /// labels.
    output_s3_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .output_s3_path = "OutputS3Path",
    };
};
