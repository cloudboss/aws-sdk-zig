const aws = @import("aws");

const MediaInsightsPipelineElementStatus = @import("media_insights_pipeline_element_status.zig").MediaInsightsPipelineElementStatus;
const KinesisVideoStreamRecordingSourceRuntimeConfiguration = @import("kinesis_video_stream_recording_source_runtime_configuration.zig").KinesisVideoStreamRecordingSourceRuntimeConfiguration;
const KinesisVideoStreamSourceRuntimeConfiguration = @import("kinesis_video_stream_source_runtime_configuration.zig").KinesisVideoStreamSourceRuntimeConfiguration;
const S3RecordingSinkRuntimeConfiguration = @import("s3_recording_sink_runtime_configuration.zig").S3RecordingSinkRuntimeConfiguration;
const MediaPipelineStatus = @import("media_pipeline_status.zig").MediaPipelineStatus;

/// A media pipeline that streams call analytics data.
pub const MediaInsightsPipeline = struct {
    /// The time at which the media insights pipeline was created.
    created_timestamp: ?i64 = null,

    /// The statuses that the elements in a media insights pipeline can have during
    /// data processing.
    element_statuses: ?[]const MediaInsightsPipelineElementStatus = null,

    /// The runtime configuration settings for a Kinesis recording video stream in a
    /// media insights pipeline.
    kinesis_video_stream_recording_source_runtime_configuration: ?KinesisVideoStreamRecordingSourceRuntimeConfiguration = null,

    /// The configuration settings for a Kinesis runtime video stream in a media
    /// insights pipeline.
    kinesis_video_stream_source_runtime_configuration: ?KinesisVideoStreamSourceRuntimeConfiguration = null,

    /// The ARN of a media insight pipeline's configuration settings.
    media_insights_pipeline_configuration_arn: ?[]const u8 = null,

    /// The runtime metadata of a media insights pipeline.
    media_insights_runtime_metadata: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of a media insights pipeline.
    media_pipeline_arn: ?[]const u8 = null,

    /// The ID of a media insights pipeline.
    media_pipeline_id: ?[]const u8 = null,

    /// The runtime configuration of the Amazon S3 bucket that stores recordings in
    /// a media insights pipeline.
    s3_recording_sink_runtime_configuration: ?S3RecordingSinkRuntimeConfiguration = null,

    /// The status of a media insights pipeline.
    status: ?MediaPipelineStatus = null,

    pub const json_field_names = .{
        .created_timestamp = "CreatedTimestamp",
        .element_statuses = "ElementStatuses",
        .kinesis_video_stream_recording_source_runtime_configuration = "KinesisVideoStreamRecordingSourceRuntimeConfiguration",
        .kinesis_video_stream_source_runtime_configuration = "KinesisVideoStreamSourceRuntimeConfiguration",
        .media_insights_pipeline_configuration_arn = "MediaInsightsPipelineConfigurationArn",
        .media_insights_runtime_metadata = "MediaInsightsRuntimeMetadata",
        .media_pipeline_arn = "MediaPipelineArn",
        .media_pipeline_id = "MediaPipelineId",
        .s3_recording_sink_runtime_configuration = "S3RecordingSinkRuntimeConfiguration",
        .status = "Status",
    };
};
