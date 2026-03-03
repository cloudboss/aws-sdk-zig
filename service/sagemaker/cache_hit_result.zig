/// Details on the cache hit of a pipeline execution step.
pub const CacheHitResult = struct {
    /// The Amazon Resource Name (ARN) of the pipeline execution.
    source_pipeline_execution_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .source_pipeline_execution_arn = "SourcePipelineExecutionArn",
    };
};
