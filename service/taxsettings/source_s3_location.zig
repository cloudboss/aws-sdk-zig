/// The Amazon S3 bucket in your account where your tax document is located.
pub const SourceS3Location = struct {
    /// The name of your Amazon S3 bucket that your tax document is located.
    bucket: []const u8,

    /// The object key of your tax document object in Amazon S3.
    key: []const u8,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key = "key",
    };
};
