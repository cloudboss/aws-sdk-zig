/// The ARN from an execution of the current pipeline.
pub const SelectiveExecutionResult = struct {
    /// The ARN from an execution of the current pipeline.
    source_pipeline_execution_arn: ?[]const u8,

    pub const json_field_names = .{
        .source_pipeline_execution_arn = "SourcePipelineExecutionArn",
    };
};
