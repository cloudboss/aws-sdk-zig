/// Provides the S3 bucket name and object name.
///
/// The region for the S3 bucket containing the S3 object must match the region
/// you use for
/// Amazon Rekognition operations.
///
/// For Amazon Rekognition to process an S3 object, the user must have
/// permission to
/// access the S3 object. For more information, see How Amazon Rekognition works
/// with IAM in the
/// Amazon Rekognition Developer Guide.
pub const S3Object = struct {
    /// Name of the S3 bucket.
    bucket: ?[]const u8,

    /// S3 object key name.
    name: ?[]const u8,

    /// If the bucket is versioning enabled, you can specify the object version.
    version: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .name = "Name",
        .version = "Version",
    };
};
