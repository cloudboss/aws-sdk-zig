/// The output properties for a detection job.
pub const OutputDataConfig = struct {
    /// When you use the `OutputDataConfig` object with asynchronous operations, you
    /// specify the Amazon S3 location where you want to write the output data. The
    /// URI must be in the
    /// same region as the API endpoint that you are calling. The location is used
    /// as the prefix for
    /// the actual location of the output.
    s3_bucket: []const u8,

    /// The path to the output data files in the S3 bucket. Amazon Comprehend
    /// Medical creates an output directory
    /// using the job ID so that the output from one job does not overwrite the
    /// output of
    /// another.
    s3_key: ?[]const u8 = null,

    pub const json_field_names = .{
        .s3_bucket = "S3Bucket",
        .s3_key = "S3Key",
    };
};
