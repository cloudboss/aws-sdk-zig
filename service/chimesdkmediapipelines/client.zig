const aws = @import("aws");
const std = @import("std");

const create_media_capture_pipeline = @import("create_media_capture_pipeline.zig");
const create_media_concatenation_pipeline = @import("create_media_concatenation_pipeline.zig");
const create_media_insights_pipeline = @import("create_media_insights_pipeline.zig");
const create_media_insights_pipeline_configuration = @import("create_media_insights_pipeline_configuration.zig");
const create_media_live_connector_pipeline = @import("create_media_live_connector_pipeline.zig");
const create_media_pipeline_kinesis_video_stream_pool = @import("create_media_pipeline_kinesis_video_stream_pool.zig");
const create_media_stream_pipeline = @import("create_media_stream_pipeline.zig");
const delete_media_capture_pipeline = @import("delete_media_capture_pipeline.zig");
const delete_media_insights_pipeline_configuration = @import("delete_media_insights_pipeline_configuration.zig");
const delete_media_pipeline = @import("delete_media_pipeline.zig");
const delete_media_pipeline_kinesis_video_stream_pool = @import("delete_media_pipeline_kinesis_video_stream_pool.zig");
const get_media_capture_pipeline = @import("get_media_capture_pipeline.zig");
const get_media_insights_pipeline_configuration = @import("get_media_insights_pipeline_configuration.zig");
const get_media_pipeline = @import("get_media_pipeline.zig");
const get_media_pipeline_kinesis_video_stream_pool = @import("get_media_pipeline_kinesis_video_stream_pool.zig");
const get_speaker_search_task = @import("get_speaker_search_task.zig");
const get_voice_tone_analysis_task = @import("get_voice_tone_analysis_task.zig");
const list_media_capture_pipelines = @import("list_media_capture_pipelines.zig");
const list_media_insights_pipeline_configurations = @import("list_media_insights_pipeline_configurations.zig");
const list_media_pipeline_kinesis_video_stream_pools = @import("list_media_pipeline_kinesis_video_stream_pools.zig");
const list_media_pipelines = @import("list_media_pipelines.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const start_speaker_search_task = @import("start_speaker_search_task.zig");
const start_voice_tone_analysis_task = @import("start_voice_tone_analysis_task.zig");
const stop_speaker_search_task = @import("stop_speaker_search_task.zig");
const stop_voice_tone_analysis_task = @import("stop_voice_tone_analysis_task.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_media_insights_pipeline_configuration = @import("update_media_insights_pipeline_configuration.zig");
const update_media_insights_pipeline_status = @import("update_media_insights_pipeline_status.zig");
const update_media_pipeline_kinesis_video_stream_pool = @import("update_media_pipeline_kinesis_video_stream_pool.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Chime SDK Media Pipelines";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a media pipeline.
    pub fn createMediaCapturePipeline(self: *Self, allocator: std.mem.Allocator, input: create_media_capture_pipeline.CreateMediaCapturePipelineInput, options: CallOptions) !create_media_capture_pipeline.CreateMediaCapturePipelineOutput {
        return create_media_capture_pipeline.execute(self, allocator, input, options);
    }

    /// Creates a media concatenation pipeline.
    pub fn createMediaConcatenationPipeline(self: *Self, allocator: std.mem.Allocator, input: create_media_concatenation_pipeline.CreateMediaConcatenationPipelineInput, options: CallOptions) !create_media_concatenation_pipeline.CreateMediaConcatenationPipelineOutput {
        return create_media_concatenation_pipeline.execute(self, allocator, input, options);
    }

    /// Creates a media insights pipeline.
    pub fn createMediaInsightsPipeline(self: *Self, allocator: std.mem.Allocator, input: create_media_insights_pipeline.CreateMediaInsightsPipelineInput, options: CallOptions) !create_media_insights_pipeline.CreateMediaInsightsPipelineOutput {
        return create_media_insights_pipeline.execute(self, allocator, input, options);
    }

    /// A structure that contains the static configurations for a media insights
    /// pipeline.
    pub fn createMediaInsightsPipelineConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_media_insights_pipeline_configuration.CreateMediaInsightsPipelineConfigurationInput, options: CallOptions) !create_media_insights_pipeline_configuration.CreateMediaInsightsPipelineConfigurationOutput {
        return create_media_insights_pipeline_configuration.execute(self, allocator, input, options);
    }

    /// Creates a media live connector pipeline in an Amazon Chime SDK meeting.
    pub fn createMediaLiveConnectorPipeline(self: *Self, allocator: std.mem.Allocator, input: create_media_live_connector_pipeline.CreateMediaLiveConnectorPipelineInput, options: CallOptions) !create_media_live_connector_pipeline.CreateMediaLiveConnectorPipelineOutput {
        return create_media_live_connector_pipeline.execute(self, allocator, input, options);
    }

    /// Creates an Amazon Kinesis Video Stream pool for use with media stream
    /// pipelines.
    ///
    /// If a meeting uses an opt-in Region as its
    /// [MediaRegion](https://docs.aws.amazon.com/chime-sdk/latest/APIReference/API_meeting-chime_CreateMeeting.html#chimesdk-meeting-chime_CreateMeeting-request-MediaRegion),
    /// the KVS stream must be in that same Region. For example, if a meeting uses
    /// the `af-south-1` Region, the KVS stream must also be in `af-south-1`.
    /// However, if the meeting uses a
    /// Region that AWS turns on by default, the KVS stream can be in any available
    /// Region, including an opt-in Region. For example, if the meeting uses
    /// `ca-central-1`, the KVS stream can be in
    /// `eu-west-2`, `us-east-1`, `af-south-1`, or any other Region that the Amazon
    /// Chime SDK supports.
    ///
    /// To learn which AWS Region a meeting uses, call the
    /// [GetMeeting](https://docs.aws.amazon.com/chime-sdk/latest/APIReference/API_meeting-chime_GetMeeting.html) API and
    /// use the
    /// [MediaRegion](https://docs.aws.amazon.com/chime-sdk/latest/APIReference/API_meeting-chime_CreateMeeting.html#chimesdk-meeting-chime_CreateMeeting-request-MediaRegion)
    /// parameter from the response.
    ///
    /// For more information about opt-in Regions, refer to [Available
    /// Regions](https://docs.aws.amazon.com/chime-sdk/latest/dg/sdk-available-regions.html) in the
    /// *Amazon Chime SDK Developer Guide*, and
    /// [Specify which AWS Regions your account can
    /// use](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-regions.html#rande-manage-enable.html),
    /// in the *AWS Account Management Reference Guide*.
    pub fn createMediaPipelineKinesisVideoStreamPool(self: *Self, allocator: std.mem.Allocator, input: create_media_pipeline_kinesis_video_stream_pool.CreateMediaPipelineKinesisVideoStreamPoolInput, options: CallOptions) !create_media_pipeline_kinesis_video_stream_pool.CreateMediaPipelineKinesisVideoStreamPoolOutput {
        return create_media_pipeline_kinesis_video_stream_pool.execute(self, allocator, input, options);
    }

    /// Creates a streaming media pipeline.
    pub fn createMediaStreamPipeline(self: *Self, allocator: std.mem.Allocator, input: create_media_stream_pipeline.CreateMediaStreamPipelineInput, options: CallOptions) !create_media_stream_pipeline.CreateMediaStreamPipelineOutput {
        return create_media_stream_pipeline.execute(self, allocator, input, options);
    }

    /// Deletes the media pipeline.
    pub fn deleteMediaCapturePipeline(self: *Self, allocator: std.mem.Allocator, input: delete_media_capture_pipeline.DeleteMediaCapturePipelineInput, options: CallOptions) !delete_media_capture_pipeline.DeleteMediaCapturePipelineOutput {
        return delete_media_capture_pipeline.execute(self, allocator, input, options);
    }

    /// Deletes the specified configuration settings.
    pub fn deleteMediaInsightsPipelineConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_media_insights_pipeline_configuration.DeleteMediaInsightsPipelineConfigurationInput, options: CallOptions) !delete_media_insights_pipeline_configuration.DeleteMediaInsightsPipelineConfigurationOutput {
        return delete_media_insights_pipeline_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the media pipeline.
    pub fn deleteMediaPipeline(self: *Self, allocator: std.mem.Allocator, input: delete_media_pipeline.DeleteMediaPipelineInput, options: CallOptions) !delete_media_pipeline.DeleteMediaPipelineOutput {
        return delete_media_pipeline.execute(self, allocator, input, options);
    }

    /// Deletes an Amazon Kinesis Video Stream pool.
    pub fn deleteMediaPipelineKinesisVideoStreamPool(self: *Self, allocator: std.mem.Allocator, input: delete_media_pipeline_kinesis_video_stream_pool.DeleteMediaPipelineKinesisVideoStreamPoolInput, options: CallOptions) !delete_media_pipeline_kinesis_video_stream_pool.DeleteMediaPipelineKinesisVideoStreamPoolOutput {
        return delete_media_pipeline_kinesis_video_stream_pool.execute(self, allocator, input, options);
    }

    /// Gets an existing media pipeline.
    pub fn getMediaCapturePipeline(self: *Self, allocator: std.mem.Allocator, input: get_media_capture_pipeline.GetMediaCapturePipelineInput, options: CallOptions) !get_media_capture_pipeline.GetMediaCapturePipelineOutput {
        return get_media_capture_pipeline.execute(self, allocator, input, options);
    }

    /// Gets the configuration settings for a media insights pipeline.
    pub fn getMediaInsightsPipelineConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_media_insights_pipeline_configuration.GetMediaInsightsPipelineConfigurationInput, options: CallOptions) !get_media_insights_pipeline_configuration.GetMediaInsightsPipelineConfigurationOutput {
        return get_media_insights_pipeline_configuration.execute(self, allocator, input, options);
    }

    /// Gets an existing media pipeline.
    pub fn getMediaPipeline(self: *Self, allocator: std.mem.Allocator, input: get_media_pipeline.GetMediaPipelineInput, options: CallOptions) !get_media_pipeline.GetMediaPipelineOutput {
        return get_media_pipeline.execute(self, allocator, input, options);
    }

    /// Gets an Kinesis video stream pool.
    pub fn getMediaPipelineKinesisVideoStreamPool(self: *Self, allocator: std.mem.Allocator, input: get_media_pipeline_kinesis_video_stream_pool.GetMediaPipelineKinesisVideoStreamPoolInput, options: CallOptions) !get_media_pipeline_kinesis_video_stream_pool.GetMediaPipelineKinesisVideoStreamPoolOutput {
        return get_media_pipeline_kinesis_video_stream_pool.execute(self, allocator, input, options);
    }

    /// Retrieves the details of the specified speaker search task.
    pub fn getSpeakerSearchTask(self: *Self, allocator: std.mem.Allocator, input: get_speaker_search_task.GetSpeakerSearchTaskInput, options: CallOptions) !get_speaker_search_task.GetSpeakerSearchTaskOutput {
        return get_speaker_search_task.execute(self, allocator, input, options);
    }

    /// Retrieves the details of a voice tone analysis task.
    pub fn getVoiceToneAnalysisTask(self: *Self, allocator: std.mem.Allocator, input: get_voice_tone_analysis_task.GetVoiceToneAnalysisTaskInput, options: CallOptions) !get_voice_tone_analysis_task.GetVoiceToneAnalysisTaskOutput {
        return get_voice_tone_analysis_task.execute(self, allocator, input, options);
    }

    /// Returns a list of media pipelines.
    pub fn listMediaCapturePipelines(self: *Self, allocator: std.mem.Allocator, input: list_media_capture_pipelines.ListMediaCapturePipelinesInput, options: CallOptions) !list_media_capture_pipelines.ListMediaCapturePipelinesOutput {
        return list_media_capture_pipelines.execute(self, allocator, input, options);
    }

    /// Lists the available media insights pipeline configurations.
    pub fn listMediaInsightsPipelineConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_media_insights_pipeline_configurations.ListMediaInsightsPipelineConfigurationsInput, options: CallOptions) !list_media_insights_pipeline_configurations.ListMediaInsightsPipelineConfigurationsOutput {
        return list_media_insights_pipeline_configurations.execute(self, allocator, input, options);
    }

    /// Lists the video stream pools in the media pipeline.
    pub fn listMediaPipelineKinesisVideoStreamPools(self: *Self, allocator: std.mem.Allocator, input: list_media_pipeline_kinesis_video_stream_pools.ListMediaPipelineKinesisVideoStreamPoolsInput, options: CallOptions) !list_media_pipeline_kinesis_video_stream_pools.ListMediaPipelineKinesisVideoStreamPoolsOutput {
        return list_media_pipeline_kinesis_video_stream_pools.execute(self, allocator, input, options);
    }

    /// Returns a list of media pipelines.
    pub fn listMediaPipelines(self: *Self, allocator: std.mem.Allocator, input: list_media_pipelines.ListMediaPipelinesInput, options: CallOptions) !list_media_pipelines.ListMediaPipelinesOutput {
        return list_media_pipelines.execute(self, allocator, input, options);
    }

    /// Lists the tags available for a media pipeline.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: CallOptions) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Starts a speaker search task.
    ///
    /// Before starting any speaker search tasks, you must provide all notices and
    /// obtain all consents from the speaker as required under applicable privacy
    /// and biometrics laws, and as required under the
    /// [AWS service terms](https://aws.amazon.com/service-terms/) for the Amazon
    /// Chime SDK.
    pub fn startSpeakerSearchTask(self: *Self, allocator: std.mem.Allocator, input: start_speaker_search_task.StartSpeakerSearchTaskInput, options: CallOptions) !start_speaker_search_task.StartSpeakerSearchTaskOutput {
        return start_speaker_search_task.execute(self, allocator, input, options);
    }

    /// Starts a voice tone analysis task. For more information about voice tone
    /// analysis, see
    /// [Using Amazon Chime SDK voice
    /// analytics](https://docs.aws.amazon.com/chime-sdk/latest/dg/voice-analytics.html)
    /// in the *Amazon Chime SDK Developer Guide*.
    ///
    /// Before starting any voice tone analysis tasks, you must provide all notices
    /// and obtain all consents from the speaker as required under applicable
    /// privacy and biometrics laws, and as required under the
    /// [AWS service terms](https://aws.amazon.com/service-terms/) for the Amazon
    /// Chime SDK.
    pub fn startVoiceToneAnalysisTask(self: *Self, allocator: std.mem.Allocator, input: start_voice_tone_analysis_task.StartVoiceToneAnalysisTaskInput, options: CallOptions) !start_voice_tone_analysis_task.StartVoiceToneAnalysisTaskOutput {
        return start_voice_tone_analysis_task.execute(self, allocator, input, options);
    }

    /// Stops a speaker search task.
    pub fn stopSpeakerSearchTask(self: *Self, allocator: std.mem.Allocator, input: stop_speaker_search_task.StopSpeakerSearchTaskInput, options: CallOptions) !stop_speaker_search_task.StopSpeakerSearchTaskOutput {
        return stop_speaker_search_task.execute(self, allocator, input, options);
    }

    /// Stops a voice tone analysis task.
    pub fn stopVoiceToneAnalysisTask(self: *Self, allocator: std.mem.Allocator, input: stop_voice_tone_analysis_task.StopVoiceToneAnalysisTaskInput, options: CallOptions) !stop_voice_tone_analysis_task.StopVoiceToneAnalysisTaskOutput {
        return stop_voice_tone_analysis_task.execute(self, allocator, input, options);
    }

    /// The ARN of the media pipeline that you want to tag. Consists of the
    /// pipeline's endpoint region, resource ID, and pipeline ID.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: CallOptions) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes any tags from a media pipeline.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: CallOptions) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates the media insights pipeline's configuration settings.
    pub fn updateMediaInsightsPipelineConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_media_insights_pipeline_configuration.UpdateMediaInsightsPipelineConfigurationInput, options: CallOptions) !update_media_insights_pipeline_configuration.UpdateMediaInsightsPipelineConfigurationOutput {
        return update_media_insights_pipeline_configuration.execute(self, allocator, input, options);
    }

    /// Updates the status of a media insights pipeline.
    pub fn updateMediaInsightsPipelineStatus(self: *Self, allocator: std.mem.Allocator, input: update_media_insights_pipeline_status.UpdateMediaInsightsPipelineStatusInput, options: CallOptions) !update_media_insights_pipeline_status.UpdateMediaInsightsPipelineStatusOutput {
        return update_media_insights_pipeline_status.execute(self, allocator, input, options);
    }

    /// Updates an Amazon Kinesis Video Stream pool in a media pipeline.
    pub fn updateMediaPipelineKinesisVideoStreamPool(self: *Self, allocator: std.mem.Allocator, input: update_media_pipeline_kinesis_video_stream_pool.UpdateMediaPipelineKinesisVideoStreamPoolInput, options: CallOptions) !update_media_pipeline_kinesis_video_stream_pool.UpdateMediaPipelineKinesisVideoStreamPoolOutput {
        return update_media_pipeline_kinesis_video_stream_pool.execute(self, allocator, input, options);
    }

    pub fn listMediaCapturePipelinesPaginator(self: *Self, params: list_media_capture_pipelines.ListMediaCapturePipelinesInput) paginator.ListMediaCapturePipelinesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMediaInsightsPipelineConfigurationsPaginator(self: *Self, params: list_media_insights_pipeline_configurations.ListMediaInsightsPipelineConfigurationsInput) paginator.ListMediaInsightsPipelineConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMediaPipelineKinesisVideoStreamPoolsPaginator(self: *Self, params: list_media_pipeline_kinesis_video_stream_pools.ListMediaPipelineKinesisVideoStreamPoolsInput) paginator.ListMediaPipelineKinesisVideoStreamPoolsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listMediaPipelinesPaginator(self: *Self, params: list_media_pipelines.ListMediaPipelinesInput) paginator.ListMediaPipelinesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
