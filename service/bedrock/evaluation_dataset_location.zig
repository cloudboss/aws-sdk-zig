/// The location in Amazon S3 where your prompt dataset is stored.
pub const EvaluationDatasetLocation = union(enum) {
    /// The S3 URI of the S3 bucket specified in the job.
    s_3_uri: ?[]const u8,

    pub const json_field_names = .{
        .s_3_uri = "s3Uri",
    };
};
