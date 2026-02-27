/// Provides information about an Amazon S3 bucket and path.
pub const S3ConfigMap = struct {
    /// The Amazon S3 location URI.
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .s_3_uri = "s3Uri",
    };
};
