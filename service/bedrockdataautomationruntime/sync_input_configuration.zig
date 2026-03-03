/// Input configuration for synchronous API
pub const SyncInputConfiguration = struct {
    /// Input data as bytes
    bytes: ?[]const u8 = null,

    /// S3 URI of the input data
    s_3_uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .bytes = "bytes",
        .s_3_uri = "s3Uri",
    };
};
