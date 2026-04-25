/// Contains information about the Amazon S3 object.
pub const S3Object = struct {
    /// The entity tag is a hash of the Amazon S3 object. The ETag reflects changes
    /// only to the contents of an object, and not its metadata.
    e_tag: ?[]const u8 = null,

    /// The key of the Amazon S3 object.
    key: ?[]const u8 = null,

    /// The version Id of the Amazon S3 object.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .e_tag = "ETag",
        .key = "Key",
        .version_id = "VersionId",
    };
};
