const MediaCapturePipelineSourceConfiguration = @import("media_capture_pipeline_source_configuration.zig").MediaCapturePipelineSourceConfiguration;
const ConcatenationSourceType = @import("concatenation_source_type.zig").ConcatenationSourceType;

/// The source type and media pipeline configuration settings in a configuration
/// object.
pub const ConcatenationSource = struct {
    /// The concatenation settings for the media pipeline in a configuration object.
    media_capture_pipeline_source_configuration: MediaCapturePipelineSourceConfiguration,

    /// The type of concatenation source in a configuration object.
    type: ConcatenationSourceType,

    pub const json_field_names = .{
        .media_capture_pipeline_source_configuration = "MediaCapturePipelineSourceConfiguration",
        .type = "Type",
    };
};
