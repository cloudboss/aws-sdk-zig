/// The Amazon S3 data source of the model to import.
pub const S3DataSource = struct {
    /// The URI of the Amazon S3 data source.
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .s_3_uri = "s3Uri",
    };
};
