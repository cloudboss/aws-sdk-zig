const MediaPipelineElementStatus = @import("media_pipeline_element_status.zig").MediaPipelineElementStatus;
const MediaInsightsPipelineConfigurationElementType = @import("media_insights_pipeline_configuration_element_type.zig").MediaInsightsPipelineConfigurationElementType;

/// The status of the pipeline element.
pub const MediaInsightsPipelineElementStatus = struct {
    /// The element's status.
    status: ?MediaPipelineElementStatus,

    /// The type of status.
    @"type": ?MediaInsightsPipelineConfigurationElementType,

    pub const json_field_names = .{
        .status = "Status",
        .@"type" = "Type",
    };
};
