/// Object Identifier is unique value to identify objects.
pub const ObjectIdentifier = struct {
    /// An entity tag (ETag) is an identifier assigned by a web server to a specific
    /// version of a resource
    /// found at a URL. This header field makes the request method conditional on
    /// `ETags`.
    ///
    /// **Note:**
    ///
    /// Entity tags (ETags) for S3 Express One Zone are random alphanumeric strings
    /// unique to the object.
    e_tag: ?[]const u8,

    /// Key name of the object.
    ///
    /// **Important:**
    ///
    /// Replacement must be made for object keys containing special characters (such
    /// as carriage returns) when using
    /// XML requests. For more information, see [
    /// XML related object key
    /// constraints](https://docs.aws.amazon.com/AmazonS3/latest/userguide/object-keys.html#object-key-xml-related-constraints).
    key: []const u8,

    /// If present, the objects are deleted only if its modification times matches
    /// the provided
    /// `Timestamp`.
    ///
    /// **Note:**
    ///
    /// This functionality is only supported for directory buckets.
    last_modified_time: ?i64,

    /// If present, the objects are deleted only if its size matches the provided
    /// size in bytes.
    ///
    /// **Note:**
    ///
    /// This functionality is only supported for directory buckets.
    size: ?i64,

    /// Version ID for the specific version of the object to delete.
    ///
    /// **Note:**
    ///
    /// This functionality is not supported for directory buckets.
    version_id: ?[]const u8,
};
