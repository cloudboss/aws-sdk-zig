const PipelineId = @import("pipeline_id.zig").PipelineId;

/// Settings for pausing a pipeline.
pub const PipelinePauseStateSettings = struct {
    /// Pipeline ID to pause ("PIPELINE_0" or "PIPELINE_1").
    pipeline_id: PipelineId,

    pub const json_field_names = .{
        .pipeline_id = "PipelineId",
    };
};
