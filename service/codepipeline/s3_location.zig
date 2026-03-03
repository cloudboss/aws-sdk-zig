/// The Amazon S3 artifact location for an action's artifacts.
pub const S3Location = struct {
    /// The Amazon S3 artifact bucket for an action's artifacts.
    bucket: ?[]const u8 = null,

    /// The artifact name.
    key: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "bucket",
        .key = "key",
    };
};
