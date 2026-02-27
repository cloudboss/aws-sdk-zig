/// The input properties for an entities detection job. This includes the name
/// of the S3
/// bucket and the path to the files to be analyzed.
pub const InputDataConfig = struct {
    /// The URI of the S3 bucket that contains the input data. The bucket must be in
    /// the same
    /// region as the API endpoint that you are calling.
    s3_bucket: []const u8,

    /// The path to the input data files in the S3 bucket.
    s3_key: ?[]const u8,

    pub const json_field_names = .{
        .s3_bucket = "S3Bucket",
        .s3_key = "S3Key",
    };
};
