/// Specifies configuration properties for a labeling set generation task run.
pub const LabelingSetGenerationTaskRunProperties = struct {
    /// The Amazon Simple Storage Service (Amazon S3) path where you will generate
    /// the labeling
    /// set.
    output_s3_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .output_s3_path = "OutputS3Path",
    };
};
