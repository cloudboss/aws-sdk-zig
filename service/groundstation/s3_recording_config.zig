/// Information about an S3 recording `Config`.
pub const S3RecordingConfig = struct {
    /// ARN of the bucket to record to.
    bucket_arn: []const u8,

    /// S3 Key prefix to prefice data files.
    prefix: ?[]const u8,

    /// ARN of the role Ground Station assumes to write data to the bucket.
    role_arn: []const u8,

    pub const json_field_names = .{
        .bucket_arn = "bucketArn",
        .prefix = "prefix",
        .role_arn = "roleArn",
    };
};
