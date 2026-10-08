/// S3 uri for input data source
pub const S3Source = struct {
    /// The S3 URI.
    uri: []const u8,

    pub const json_field_names = .{
        .uri = "uri",
    };
};
