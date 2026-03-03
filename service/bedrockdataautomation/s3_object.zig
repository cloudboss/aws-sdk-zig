/// S3 object
pub const S3Object = struct {
    /// S3 uri.
    s_3_uri: []const u8,

    /// S3 object version.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .s_3_uri = "s3Uri",
        .version = "version",
    };
};
