/// Information about the S3 object that was scanned
pub const S3ObjectDetail = struct {
    /// The entity tag is a hash of the S3 object. The ETag reflects changes only to
    /// the contents of
    /// an object, and not its metadata.
    e_tag: ?[]const u8,

    /// Hash of the threat detected in this finding.
    hash: ?[]const u8,

    /// Key of the S3 object.
    key: ?[]const u8,

    /// Amazon Resource Name (ARN) of the S3 object.
    object_arn: ?[]const u8,

    /// Version ID of the object.
    version_id: ?[]const u8,

    pub const json_field_names = .{
        .e_tag = "ETag",
        .hash = "Hash",
        .key = "Key",
        .object_arn = "ObjectArn",
        .version_id = "VersionId",
    };
};
