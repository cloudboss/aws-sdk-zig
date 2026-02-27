/// The Amazon S3 location configuration of a resource.
pub const S3Location = struct {
    /// The name of the Amazon S3 bucket where the resource is stored.
    bucket: []const u8,

    /// The name of the Amazon S3 prefix/key where the resource is stored.
    prefix: []const u8,

    /// The name of the Amazon S3 version ID where the resource is stored
    /// (Optional).
    version_id: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "bucket",
        .prefix = "prefix",
        .version_id = "versionId",
    };
};
