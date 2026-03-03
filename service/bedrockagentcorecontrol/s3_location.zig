/// The Amazon S3 location for storing data. This structure defines where in
/// Amazon S3 data is stored.
pub const S3Location = struct {
    /// The name of the Amazon S3 bucket. This bucket contains the stored data.
    bucket: []const u8,

    /// The prefix for objects in the Amazon S3 bucket. This prefix is added to the
    /// object keys to organize the data.
    prefix: []const u8,

    /// The version ID of the Amazon Amazon S3 object. If not specified, the latest
    /// version of the object is used.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .prefix = "prefix",
        .version_id = "versionId",
    };
};
