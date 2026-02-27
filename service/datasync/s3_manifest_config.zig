/// Specifies the S3 bucket where you're hosting the manifest that you want
/// DataSync to use. For more information and configuration examples, see
/// [Specifying what DataSync transfers by using a
/// manifest](https://docs.aws.amazon.com/datasync/latest/userguide/transferring-with-manifest.html).
pub const S3ManifestConfig = struct {
    /// Specifies the Identity and Access Management (IAM) role that allows DataSync
    /// to access your manifest. For more information, see [Providing DataSync
    /// access to your
    /// manifest](https://docs.aws.amazon.com/datasync/latest/userguide/transferring-with-manifest.html#transferring-with-manifest-access).
    bucket_access_role_arn: []const u8,

    /// Specifies the Amazon S3 object key of your manifest. This can include a
    /// prefix
    /// (for example, `prefix/my-manifest.csv`).
    manifest_object_path: []const u8,

    /// Specifies the object version ID of the manifest that you want DataSync to
    /// use.
    /// If you don't set this, DataSync uses the latest version of the object.
    manifest_object_version_id: ?[]const u8,

    /// Specifies the Amazon Resource Name (ARN) of the S3 bucket where you're
    /// hosting your
    /// manifest.
    s3_bucket_arn: []const u8,

    pub const json_field_names = .{
        .bucket_access_role_arn = "BucketAccessRoleArn",
        .manifest_object_path = "ManifestObjectPath",
        .manifest_object_version_id = "ManifestObjectVersionId",
        .s3_bucket_arn = "S3BucketArn",
    };
};
