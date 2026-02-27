/// An Amazon S3 location.
pub const S3Location = struct {
    /// The location's URI. For example, `s3://my-bucket/chunk-processor/`.
    uri: []const u8,

    pub const json_field_names = .{
        .uri = "uri",
    };
};
