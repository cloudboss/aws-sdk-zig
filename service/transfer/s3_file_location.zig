/// Specifies the details for the file location for the file that's being used
/// in the workflow. Only applicable if you are using S3 storage.
pub const S3FileLocation = struct {
    /// Specifies the S3 bucket that contains the file being used.
    bucket: ?[]const u8 = null,

    /// The entity tag is a hash of the object. The ETag reflects changes only to
    /// the contents of an object, not its metadata.
    etag: ?[]const u8 = null,

    /// The name assigned to the file when it was created in Amazon S3. You use the
    /// object key to retrieve the object.
    key: ?[]const u8 = null,

    /// Specifies the file version.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .etag = "Etag",
        .key = "Key",
        .version_id = "VersionId",
    };
};
