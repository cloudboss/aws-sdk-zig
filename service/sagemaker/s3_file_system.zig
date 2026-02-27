/// A custom file system in Amazon S3. This is only supported in Amazon
/// SageMaker Unified Studio.
pub const S3FileSystem = struct {
    /// The Amazon S3 URI that specifies the location in S3 where files are stored,
    /// which is mounted within the Studio environment. For example:
    /// `s3://<bucket-name>/<prefix>/`.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .s3_uri = "S3Uri",
    };
};
