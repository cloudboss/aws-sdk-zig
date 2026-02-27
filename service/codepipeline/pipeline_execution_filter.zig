const SucceededInStageFilter = @import("succeeded_in_stage_filter.zig").SucceededInStageFilter;

/// The pipeline execution to filter on.
pub const PipelineExecutionFilter = struct {
    /// Filter for pipeline executions where the stage was successful in the current
    /// pipeline
    /// version.
    succeeded_in_stage: ?SucceededInStageFilter,

    pub const json_field_names = .{
        .succeeded_in_stage = "succeededInStage",
    };
};
