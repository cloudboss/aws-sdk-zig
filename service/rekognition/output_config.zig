/// The S3 bucket and folder location where training output is placed.
pub const OutputConfig = struct {
    /// The S3 bucket where training output is placed.
    s3_bucket: ?[]const u8 = null,

    /// The prefix applied to the training output files.
    s3_key_prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .s3_bucket = "S3Bucket",
        .s3_key_prefix = "S3KeyPrefix",
    };
};
