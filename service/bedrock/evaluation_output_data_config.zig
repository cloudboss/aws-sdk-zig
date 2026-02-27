/// The Amazon S3 location where the results of your evaluation job are saved.
pub const EvaluationOutputDataConfig = struct {
    /// The Amazon S3 URI where the results of the evaluation job are saved.
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .s_3_uri = "s3Uri",
    };
};
