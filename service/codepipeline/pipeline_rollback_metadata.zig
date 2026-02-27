/// The metadata for the stage execution to be rolled back.
pub const PipelineRollbackMetadata = struct {
    /// The pipeline execution ID to which the stage will be rolled back.
    rollback_target_pipeline_execution_id: ?[]const u8,

    pub const json_field_names = .{
        .rollback_target_pipeline_execution_id = "rollbackTargetPipelineExecutionId",
    };
};
