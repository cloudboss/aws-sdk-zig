/// The Amazon S3 data source for an AI workload.
pub const AIWorkloadS3DataSource = struct {
    /// The Amazon S3 URI of the data.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .s3_uri = "S3Uri",
    };
};
