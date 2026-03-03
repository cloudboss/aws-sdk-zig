/// Information about the protected S3 bucket resource.
pub const CreateS3BucketResource = struct {
    /// Name of the S3 bucket.
    bucket_name: ?[]const u8 = null,

    /// Information about the specified object prefixes. The S3 object will be
    /// scanned only
    /// if it belongs to any of the specified object prefixes.
    object_prefixes: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .bucket_name = "BucketName",
        .object_prefixes = "ObjectPrefixes",
    };
};
