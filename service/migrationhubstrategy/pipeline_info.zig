const PipelineType = @import("pipeline_type.zig").PipelineType;

/// Detailed information of the pipeline.
pub const PipelineInfo = struct {
    /// The time when the pipeline info was configured.
    pipeline_configuration_time_stamp: ?[]const u8 = null,

    /// The type of pipeline.
    pipeline_type: ?PipelineType = null,

    pub const json_field_names = .{
        .pipeline_configuration_time_stamp = "pipelineConfigurationTimeStamp",
        .pipeline_type = "pipelineType",
    };
};
