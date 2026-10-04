/// Contains the input data configuration for an advanced prompt optimization
/// job.
pub const AdvancedPromptOptimizationInputConfig = struct {
    /// The S3 URI of the JSONL input file containing prompt templates and
    /// evaluation samples.
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .s_3_uri = "s3Uri",
    };
};
