/// Contains the output data configuration for an advanced prompt optimization
/// job.
pub const AdvancedPromptOptimizationOutputConfig = struct {
    /// The S3 URI prefix where the optimization results will be written.
    s_3_uri: []const u8,

    pub const json_field_names = .{
        .s_3_uri = "s3Uri",
    };
};
