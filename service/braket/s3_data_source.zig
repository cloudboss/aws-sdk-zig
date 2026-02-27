/// Information about the Amazon S3 storage used by the Amazon Braket hybrid
/// job.
pub const S3DataSource = struct {
    /// Depending on the value specified for the `S3DataType`, identifies either a
    /// key name prefix or a manifest that locates the S3 data source.
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .s_3_uri = "s3Uri",
    };
};
