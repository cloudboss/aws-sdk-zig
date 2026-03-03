/// The current source for one of the pipelines in the multiplex.
pub const MultiplexProgramPipelineDetail = struct {
    /// Identifies the channel pipeline that is currently active for the pipeline
    /// (identified by PipelineId) in the multiplex.
    active_channel_pipeline: ?[]const u8 = null,

    /// Identifies a specific pipeline in the multiplex.
    pipeline_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_channel_pipeline = "ActiveChannelPipeline",
        .pipeline_id = "PipelineId",
    };
};
