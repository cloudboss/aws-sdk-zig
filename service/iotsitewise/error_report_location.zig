/// The Amazon S3 destination where errors associated with the job creation
/// request are saved.
pub const ErrorReportLocation = struct {
    /// The name of the Amazon S3 bucket to which errors associated with the bulk
    /// import job are
    /// sent.
    bucket: []const u8,

    /// Amazon S3 uses the prefix as a folder name to organize data in the bucket.
    /// Each Amazon S3 object has
    /// a key that is its unique identifier in the bucket. Each object in a bucket
    /// has exactly one
    /// key. The prefix must end with a forward slash (/). For more information, see
    /// [Organizing objects
    /// using
    /// prefixes](https://docs.aws.amazon.com/AmazonS3/latest/userguide/using-prefixes.html) in the *Amazon Simple Storage Service User Guide*.
    prefix: []const u8,

    pub const json_field_names = .{
        .bucket = "bucket",
        .prefix = "prefix",
    };
};
