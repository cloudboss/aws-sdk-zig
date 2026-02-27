const ChimeSdkMeetingConfiguration = @import("chime_sdk_meeting_configuration.zig").ChimeSdkMeetingConfiguration;
const MediaPipelineSinkType = @import("media_pipeline_sink_type.zig").MediaPipelineSinkType;
const MediaPipelineSourceType = @import("media_pipeline_source_type.zig").MediaPipelineSourceType;
const SseAwsKeyManagementParams = @import("sse_aws_key_management_params.zig").SseAwsKeyManagementParams;
const MediaPipelineStatus = @import("media_pipeline_status.zig").MediaPipelineStatus;

/// A media pipeline object consisting of an ID, source type, source ARN, a sink
/// type, a sink ARN, and a configuration object.
pub const MediaCapturePipeline = struct {
    /// The configuration for a specified media pipeline. `SourceType` must
    /// be `ChimeSdkMeeting`.
    chime_sdk_meeting_configuration: ?ChimeSdkMeetingConfiguration,

    /// The time at which the pipeline was created, in ISO 8601 format.
    created_timestamp: ?i64,

    /// The ARN of the media capture pipeline
    media_pipeline_arn: ?[]const u8,

    /// The ID of a media pipeline.
    media_pipeline_id: ?[]const u8,

    /// ARN of the destination to which the media artifacts are saved.
    sink_arn: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the sink role to be used with
    /// `AwsKmsKeyId`
    /// in `SseAwsKeyManagementParams`.
    sink_iam_role_arn: ?[]const u8,

    /// Destination type to which the media artifacts are saved. You must use an S3
    /// Bucket.
    sink_type: ?MediaPipelineSinkType,

    /// ARN of the source from which the media artifacts are saved.
    source_arn: ?[]const u8,

    /// Source type from which media artifacts are saved. You must use
    /// `ChimeMeeting`.
    source_type: ?MediaPipelineSourceType,

    /// An object that contains server side encryption parameters to be used by
    /// media capture
    /// pipeline. The parameters can also be used by media concatenation pipeline
    /// taking media
    /// capture pipeline as a media source.
    sse_aws_key_management_params: ?SseAwsKeyManagementParams,

    /// The status of the media pipeline.
    status: ?MediaPipelineStatus,

    /// The time at which the pipeline was updated, in ISO 8601 format.
    updated_timestamp: ?i64,

    pub const json_field_names = .{
        .chime_sdk_meeting_configuration = "ChimeSdkMeetingConfiguration",
        .created_timestamp = "CreatedTimestamp",
        .media_pipeline_arn = "MediaPipelineArn",
        .media_pipeline_id = "MediaPipelineId",
        .sink_arn = "SinkArn",
        .sink_iam_role_arn = "SinkIamRoleArn",
        .sink_type = "SinkType",
        .source_arn = "SourceArn",
        .source_type = "SourceType",
        .sse_aws_key_management_params = "SseAwsKeyManagementParams",
        .status = "Status",
        .updated_timestamp = "UpdatedTimestamp",
    };
};
