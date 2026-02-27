/// Specifies the details for the Amazon S3 file location that is being used
/// with Amazon Web Services B2B Data Interchange. File locations in Amazon S3
/// are identified using a combination of the bucket and key.
pub const S3Location = struct {
    /// Specifies the name of the Amazon S3 bucket.
    bucket_name: ?[]const u8,

    /// Specifies the Amazon S3 key for the file location.
    key: ?[]const u8,

    pub const json_field_names = .{
        .bucket_name = "bucketName",
        .key = "key",
    };
};
