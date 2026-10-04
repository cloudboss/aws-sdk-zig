/// Identifies a sample data file in Amazon S3 to use as the source when
/// creating a data transformation profile. Valid only when the source format is
/// Comma-separated values (CSV).
pub const SampleDataSource = struct {
    /// The Amazon S3 URI of the sample data file.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .s3_uri = "S3Uri",
    };
};
