/// Contains the information required to locate a manifest object. Manifests
/// can't be
/// imported from directory buckets. For more information, see [Directory
/// buckets](https://docs.aws.amazon.com/AmazonS3/latest/userguide/directory-buckets-overview.html).
pub const JobManifestLocation = struct {
    /// The ETag for the specified manifest object.
    e_tag: []const u8,

    /// The Amazon Resource Name (ARN) for a manifest object.
    ///
    /// When you're using XML requests, you must
    /// replace special characters (such as carriage returns) in object keys with
    /// their equivalent XML entity codes.
    /// For more information, see [
    /// XML-related object key
    /// constraints](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-xml-related-constraints) in the *Amazon S3 User Guide*.
    object_arn: []const u8,

    /// The optional version ID to identify a specific version of the manifest
    /// object.
    object_version_id: ?[]const u8 = null,
};
