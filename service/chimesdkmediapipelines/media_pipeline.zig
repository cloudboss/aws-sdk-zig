const MediaCapturePipeline = @import("media_capture_pipeline.zig").MediaCapturePipeline;
const MediaConcatenationPipeline = @import("media_concatenation_pipeline.zig").MediaConcatenationPipeline;
const MediaInsightsPipeline = @import("media_insights_pipeline.zig").MediaInsightsPipeline;
const MediaLiveConnectorPipeline = @import("media_live_connector_pipeline.zig").MediaLiveConnectorPipeline;
const MediaStreamPipeline = @import("media_stream_pipeline.zig").MediaStreamPipeline;

/// A pipeline consisting of a media capture, media concatenation, or
/// live-streaming pipeline.
pub const MediaPipeline = struct {
    /// A pipeline that enables users to capture audio and video.
    media_capture_pipeline: ?MediaCapturePipeline,

    /// The media concatenation pipeline in a media pipeline.
    media_concatenation_pipeline: ?MediaConcatenationPipeline,

    /// The media insights pipeline of a media pipeline.
    media_insights_pipeline: ?MediaInsightsPipeline,

    /// The connector pipeline of the media pipeline.
    media_live_connector_pipeline: ?MediaLiveConnectorPipeline,

    /// Designates a media pipeline as a media stream pipeline.
    media_stream_pipeline: ?MediaStreamPipeline,

    pub const json_field_names = .{
        .media_capture_pipeline = "MediaCapturePipeline",
        .media_concatenation_pipeline = "MediaConcatenationPipeline",
        .media_insights_pipeline = "MediaInsightsPipeline",
        .media_live_connector_pipeline = "MediaLiveConnectorPipeline",
        .media_stream_pipeline = "MediaStreamPipeline",
    };
};
