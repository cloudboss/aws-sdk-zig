/// For a Managed Service for Apache Flink application provides a
/// description of an Amazon S3 object, including the Amazon Resource Name (ARN)
/// of the S3 bucket,
/// the name of the Amazon S3 object that contains the data, and the version
/// number of the Amazon
/// S3 object that contains the data.
pub const S3ContentLocation = struct {
    /// The Amazon Resource Name (ARN) for the S3 bucket containing the application
    /// code.
    bucket_arn: []const u8,

    /// The file key for the object containing the application code.
    file_key: []const u8,

    /// The version of the object containing the application code.
    object_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket_arn = "BucketARN",
        .file_key = "FileKey",
        .object_version = "ObjectVersion",
    };
};
