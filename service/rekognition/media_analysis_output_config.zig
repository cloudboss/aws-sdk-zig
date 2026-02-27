/// Output configuration provided in the job creation request.
pub const MediaAnalysisOutputConfig = struct {
    /// Specifies the Amazon S3 bucket to contain the output of the media analysis
    /// job.
    s3_bucket: []const u8,

    /// Specifies the Amazon S3 key prefix that comes after the name of the bucket
    /// you have
    /// designated for storage.
    s3_key_prefix: ?[]const u8,

    pub const json_field_names = .{
        .s3_bucket = "S3Bucket",
        .s3_key_prefix = "S3KeyPrefix",
    };
};
