/// Contains information about the Amazon S3 location from which the test set is
/// imported.
pub const TestSetImportInputLocation = struct {
    /// The name of the Amazon S3 bucket.
    s_3_bucket_name: []const u8,

    /// The path inside the Amazon S3 bucket pointing to the test-set CSV file.
    s_3_path: []const u8,

    pub const json_field_names = .{
        .s_3_bucket_name = "s3BucketName",
        .s_3_path = "s3Path",
    };
};
