const aws = @import("aws");
const std = @import("std");

const batch_get_channel = @import("batch_get_channel.zig");
const batch_get_stream_key = @import("batch_get_stream_key.zig");
const batch_start_viewer_session_revocation = @import("batch_start_viewer_session_revocation.zig");
const create_channel = @import("create_channel.zig");
const create_playback_restriction_policy = @import("create_playback_restriction_policy.zig");
const create_recording_configuration = @import("create_recording_configuration.zig");
const create_stream_key = @import("create_stream_key.zig");
const delete_channel = @import("delete_channel.zig");
const delete_playback_key_pair = @import("delete_playback_key_pair.zig");
const delete_playback_restriction_policy = @import("delete_playback_restriction_policy.zig");
const delete_recording_configuration = @import("delete_recording_configuration.zig");
const delete_stream_key = @import("delete_stream_key.zig");
const get_channel = @import("get_channel.zig");
const get_playback_key_pair = @import("get_playback_key_pair.zig");
const get_playback_restriction_policy = @import("get_playback_restriction_policy.zig");
const get_recording_configuration = @import("get_recording_configuration.zig");
const get_stream = @import("get_stream.zig");
const get_stream_key = @import("get_stream_key.zig");
const get_stream_session = @import("get_stream_session.zig");
const import_playback_key_pair = @import("import_playback_key_pair.zig");
const list_channels = @import("list_channels.zig");
const list_playback_key_pairs = @import("list_playback_key_pairs.zig");
const list_playback_restriction_policies = @import("list_playback_restriction_policies.zig");
const list_recording_configurations = @import("list_recording_configurations.zig");
const list_stream_keys = @import("list_stream_keys.zig");
const list_stream_sessions = @import("list_stream_sessions.zig");
const list_streams = @import("list_streams.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_metadata = @import("put_metadata.zig");
const start_viewer_session_revocation = @import("start_viewer_session_revocation.zig");
const stop_stream = @import("stop_stream.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_channel = @import("update_channel.zig");
const update_playback_restriction_policy = @import("update_playback_restriction_policy.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ivs";

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

    /// Performs GetChannel on multiple ARNs simultaneously.
    pub fn batchGetChannel(self: *Self, allocator: std.mem.Allocator, input: batch_get_channel.BatchGetChannelInput, options: batch_get_channel.Options) !batch_get_channel.BatchGetChannelOutput {
        return batch_get_channel.execute(self, allocator, input, options);
    }

    /// Performs GetStreamKey on multiple ARNs simultaneously.
    pub fn batchGetStreamKey(self: *Self, allocator: std.mem.Allocator, input: batch_get_stream_key.BatchGetStreamKeyInput, options: batch_get_stream_key.Options) !batch_get_stream_key.BatchGetStreamKeyOutput {
        return batch_get_stream_key.execute(self, allocator, input, options);
    }

    /// Performs StartViewerSessionRevocation on multiple channel ARN and viewer
    /// ID pairs simultaneously.
    pub fn batchStartViewerSessionRevocation(self: *Self, allocator: std.mem.Allocator, input: batch_start_viewer_session_revocation.BatchStartViewerSessionRevocationInput, options: batch_start_viewer_session_revocation.Options) !batch_start_viewer_session_revocation.BatchStartViewerSessionRevocationOutput {
        return batch_start_viewer_session_revocation.execute(self, allocator, input, options);
    }

    /// Creates a new channel and an associated stream key to start streaming.
    pub fn createChannel(self: *Self, allocator: std.mem.Allocator, input: create_channel.CreateChannelInput, options: create_channel.Options) !create_channel.CreateChannelOutput {
        return create_channel.execute(self, allocator, input, options);
    }

    /// Creates a new playback restriction policy, for constraining playback by
    /// countries and/or
    /// origins.
    pub fn createPlaybackRestrictionPolicy(self: *Self, allocator: std.mem.Allocator, input: create_playback_restriction_policy.CreatePlaybackRestrictionPolicyInput, options: create_playback_restriction_policy.Options) !create_playback_restriction_policy.CreatePlaybackRestrictionPolicyOutput {
        return create_playback_restriction_policy.execute(self, allocator, input, options);
    }

    /// Creates a new recording configuration, used to enable recording to Amazon
    /// S3.
    ///
    /// **Known issue:** In the us-east-1 region, if you use the
    /// Amazon Web Services CLI to create a recording configuration, it returns
    /// success even if the
    /// S3 bucket is in a different region. In this case, the `state` of the
    /// recording
    /// configuration is `CREATE_FAILED` (instead of `ACTIVE`). (In other
    /// regions, the CLI correctly returns failure if the bucket is in a different
    /// region.)
    ///
    /// **Workaround:** Ensure that your S3 bucket is in the same
    /// region as the recording configuration. If you create a recording
    /// configuration in a different
    /// region as your S3 bucket, delete that recording configuration and create a
    /// new one with an S3
    /// bucket from the correct region.
    pub fn createRecordingConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_recording_configuration.CreateRecordingConfigurationInput, options: create_recording_configuration.Options) !create_recording_configuration.CreateRecordingConfigurationOutput {
        return create_recording_configuration.execute(self, allocator, input, options);
    }

    /// Creates a stream key, used to initiate a stream, for the specified channel
    /// ARN.
    ///
    /// Note that CreateChannel creates a stream key. If you subsequently use
    /// CreateStreamKey on the same channel, it will fail because a stream key
    /// already exists and
    /// there is a limit of 1 stream key per channel. To reset the stream key on a
    /// channel, use DeleteStreamKey and then CreateStreamKey.
    pub fn createStreamKey(self: *Self, allocator: std.mem.Allocator, input: create_stream_key.CreateStreamKeyInput, options: create_stream_key.Options) !create_stream_key.CreateStreamKeyOutput {
        return create_stream_key.execute(self, allocator, input, options);
    }

    /// Deletes the specified channel and its associated stream keys.
    ///
    /// If you try to delete a live channel, you will get an error (409
    /// ConflictException). To
    /// delete a channel that is live, call StopStream, wait for the Amazon
    /// EventBridge "Stream End" event (to verify that the stream's state is no
    /// longer Live), then
    /// call DeleteChannel. (See [ Using EventBridge with Amazon
    /// IVS](https://docs.aws.amazon.com/ivs/latest/userguide/eventbridge.html).)
    pub fn deleteChannel(self: *Self, allocator: std.mem.Allocator, input: delete_channel.DeleteChannelInput, options: delete_channel.Options) !delete_channel.DeleteChannelOutput {
        return delete_channel.execute(self, allocator, input, options);
    }

    /// Deletes a specified authorization key pair. This invalidates future viewer
    /// tokens
    /// generated using the key pair’s `privateKey`. For more information, see
    /// [Setting Up Private
    /// Channels](https://docs.aws.amazon.com/ivs/latest/userguide/private-channels.html) in the *Amazon IVS User Guide*.
    pub fn deletePlaybackKeyPair(self: *Self, allocator: std.mem.Allocator, input: delete_playback_key_pair.DeletePlaybackKeyPairInput, options: delete_playback_key_pair.Options) !delete_playback_key_pair.DeletePlaybackKeyPairOutput {
        return delete_playback_key_pair.execute(self, allocator, input, options);
    }

    /// Deletes the specified playback restriction policy.
    pub fn deletePlaybackRestrictionPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_playback_restriction_policy.DeletePlaybackRestrictionPolicyInput, options: delete_playback_restriction_policy.Options) !delete_playback_restriction_policy.DeletePlaybackRestrictionPolicyOutput {
        return delete_playback_restriction_policy.execute(self, allocator, input, options);
    }

    /// Deletes the recording configuration for the specified ARN.
    ///
    /// If you try to delete a recording configuration that is associated with a
    /// channel, you will
    /// get an error (409 ConflictException). To avoid this, for all channels that
    /// reference the
    /// recording configuration, first use UpdateChannel to set the
    /// `recordingConfigurationArn` field to an empty string, then use
    /// DeleteRecordingConfiguration.
    pub fn deleteRecordingConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_recording_configuration.DeleteRecordingConfigurationInput, options: delete_recording_configuration.Options) !delete_recording_configuration.DeleteRecordingConfigurationOutput {
        return delete_recording_configuration.execute(self, allocator, input, options);
    }

    /// Deletes the stream key for the specified ARN, so it can no longer be used to
    /// stream.
    pub fn deleteStreamKey(self: *Self, allocator: std.mem.Allocator, input: delete_stream_key.DeleteStreamKeyInput, options: delete_stream_key.Options) !delete_stream_key.DeleteStreamKeyOutput {
        return delete_stream_key.execute(self, allocator, input, options);
    }

    /// Gets the channel configuration for the specified channel ARN. See also
    /// BatchGetChannel.
    pub fn getChannel(self: *Self, allocator: std.mem.Allocator, input: get_channel.GetChannelInput, options: get_channel.Options) !get_channel.GetChannelOutput {
        return get_channel.execute(self, allocator, input, options);
    }

    /// Gets a specified playback authorization key pair and returns the `arn` and
    /// `fingerprint`. The `privateKey` held by the caller can be used to
    /// generate viewer authorization tokens, to grant viewers access to private
    /// channels. For more
    /// information, see [Setting Up Private
    /// Channels](https://docs.aws.amazon.com/ivs/latest/userguide/private-channels.html) in the *Amazon IVS User
    /// Guide*.
    pub fn getPlaybackKeyPair(self: *Self, allocator: std.mem.Allocator, input: get_playback_key_pair.GetPlaybackKeyPairInput, options: get_playback_key_pair.Options) !get_playback_key_pair.GetPlaybackKeyPairOutput {
        return get_playback_key_pair.execute(self, allocator, input, options);
    }

    /// Gets the specified playback restriction policy.
    pub fn getPlaybackRestrictionPolicy(self: *Self, allocator: std.mem.Allocator, input: get_playback_restriction_policy.GetPlaybackRestrictionPolicyInput, options: get_playback_restriction_policy.Options) !get_playback_restriction_policy.GetPlaybackRestrictionPolicyOutput {
        return get_playback_restriction_policy.execute(self, allocator, input, options);
    }

    /// Gets the recording configuration for the specified ARN.
    pub fn getRecordingConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_recording_configuration.GetRecordingConfigurationInput, options: get_recording_configuration.Options) !get_recording_configuration.GetRecordingConfigurationOutput {
        return get_recording_configuration.execute(self, allocator, input, options);
    }

    /// Gets information about the active (live) stream on a specified channel.
    pub fn getStream(self: *Self, allocator: std.mem.Allocator, input: get_stream.GetStreamInput, options: get_stream.Options) !get_stream.GetStreamOutput {
        return get_stream.execute(self, allocator, input, options);
    }

    /// Gets stream-key information for a specified ARN.
    pub fn getStreamKey(self: *Self, allocator: std.mem.Allocator, input: get_stream_key.GetStreamKeyInput, options: get_stream_key.Options) !get_stream_key.GetStreamKeyOutput {
        return get_stream_key.execute(self, allocator, input, options);
    }

    /// Gets metadata on a specified stream.
    pub fn getStreamSession(self: *Self, allocator: std.mem.Allocator, input: get_stream_session.GetStreamSessionInput, options: get_stream_session.Options) !get_stream_session.GetStreamSessionOutput {
        return get_stream_session.execute(self, allocator, input, options);
    }

    /// Imports the public portion of a new key pair and returns its `arn` and
    /// `fingerprint`. The `privateKey` can then be used to generate viewer
    /// authorization tokens, to grant viewers access to private channels. For more
    /// information, see
    /// [Setting Up
    /// Private
    /// Channels](https://docs.aws.amazon.com/ivs/latest/userguide/private-channels.html) in the *Amazon IVS User Guide*.
    pub fn importPlaybackKeyPair(self: *Self, allocator: std.mem.Allocator, input: import_playback_key_pair.ImportPlaybackKeyPairInput, options: import_playback_key_pair.Options) !import_playback_key_pair.ImportPlaybackKeyPairOutput {
        return import_playback_key_pair.execute(self, allocator, input, options);
    }

    /// Gets summary information about all channels in your account, in the Amazon
    /// Web Services
    /// region where the API request is processed. This list can be filtered to
    /// match a specified name
    /// or recording-configuration ARN. Filters are mutually exclusive and cannot be
    /// used together. If
    /// you try to use both filters, you will get an error (409 ConflictException).
    pub fn listChannels(self: *Self, allocator: std.mem.Allocator, input: list_channels.ListChannelsInput, options: list_channels.Options) !list_channels.ListChannelsOutput {
        return list_channels.execute(self, allocator, input, options);
    }

    /// Gets summary information about playback key pairs. For more information, see
    /// [Setting Up Private
    /// Channels](https://docs.aws.amazon.com/ivs/latest/userguide/private-channels.html) in the *Amazon IVS User Guide*.
    pub fn listPlaybackKeyPairs(self: *Self, allocator: std.mem.Allocator, input: list_playback_key_pairs.ListPlaybackKeyPairsInput, options: list_playback_key_pairs.Options) !list_playback_key_pairs.ListPlaybackKeyPairsOutput {
        return list_playback_key_pairs.execute(self, allocator, input, options);
    }

    /// Gets summary information about playback restriction policies.
    pub fn listPlaybackRestrictionPolicies(self: *Self, allocator: std.mem.Allocator, input: list_playback_restriction_policies.ListPlaybackRestrictionPoliciesInput, options: list_playback_restriction_policies.Options) !list_playback_restriction_policies.ListPlaybackRestrictionPoliciesOutput {
        return list_playback_restriction_policies.execute(self, allocator, input, options);
    }

    /// Gets summary information about all recording configurations in your account,
    /// in the
    /// Amazon Web Services region where the API request is processed.
    pub fn listRecordingConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_recording_configurations.ListRecordingConfigurationsInput, options: list_recording_configurations.Options) !list_recording_configurations.ListRecordingConfigurationsOutput {
        return list_recording_configurations.execute(self, allocator, input, options);
    }

    /// Gets summary information about stream keys for the specified channel.
    pub fn listStreamKeys(self: *Self, allocator: std.mem.Allocator, input: list_stream_keys.ListStreamKeysInput, options: list_stream_keys.Options) !list_stream_keys.ListStreamKeysOutput {
        return list_stream_keys.execute(self, allocator, input, options);
    }

    /// Gets a summary of current and previous streams for a specified channel in
    /// your account, in
    /// the AWS region where the API request is processed.
    pub fn listStreamSessions(self: *Self, allocator: std.mem.Allocator, input: list_stream_sessions.ListStreamSessionsInput, options: list_stream_sessions.Options) !list_stream_sessions.ListStreamSessionsOutput {
        return list_stream_sessions.execute(self, allocator, input, options);
    }

    /// Gets summary information about live streams in your account, in the Amazon
    /// Web Services
    /// region where the API request is processed.
    pub fn listStreams(self: *Self, allocator: std.mem.Allocator, input: list_streams.ListStreamsInput, options: list_streams.Options) !list_streams.ListStreamsOutput {
        return list_streams.execute(self, allocator, input, options);
    }

    /// Gets information about Amazon Web Services tags for the specified ARN.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Inserts metadata into the active stream of the specified channel. At most 5
    /// requests per
    /// second per channel are allowed, each with a maximum 1 KB payload. (If 5 TPS
    /// is not sufficient
    /// for your needs, we recommend batching your data into a single PutMetadata
    /// call.) At most 155
    /// requests per second per account are allowed. Also see [Embedding Metadata
    /// within a Video
    /// Stream](https://docs.aws.amazon.com/ivs/latest/userguide/metadata.html) in
    /// the *Amazon IVS User Guide*.
    pub fn putMetadata(self: *Self, allocator: std.mem.Allocator, input: put_metadata.PutMetadataInput, options: put_metadata.Options) !put_metadata.PutMetadataOutput {
        return put_metadata.execute(self, allocator, input, options);
    }

    /// Starts the process of revoking the viewer session associated with a
    /// specified channel ARN
    /// and viewer ID. Optionally, you can provide a version to revoke viewer
    /// sessions less than and
    /// including that version. For instructions on associating a viewer ID with a
    /// viewer session, see
    /// [Setting Up
    /// Private
    /// Channels](https://docs.aws.amazon.com/ivs/latest/userguide/private-channels.html).
    pub fn startViewerSessionRevocation(self: *Self, allocator: std.mem.Allocator, input: start_viewer_session_revocation.StartViewerSessionRevocationInput, options: start_viewer_session_revocation.Options) !start_viewer_session_revocation.StartViewerSessionRevocationOutput {
        return start_viewer_session_revocation.execute(self, allocator, input, options);
    }

    /// Disconnects the incoming RTMPS stream for the specified channel. Can be used
    /// in
    /// conjunction with DeleteStreamKey to prevent further streaming to a
    /// channel.
    ///
    /// Many streaming client-software libraries automatically reconnect a dropped
    /// RTMPS
    /// session, so to stop the stream permanently, you may want to first revoke the
    /// `streamKey` attached to the channel.
    pub fn stopStream(self: *Self, allocator: std.mem.Allocator, input: stop_stream.StopStreamInput, options: stop_stream.Options) !stop_stream.StopStreamOutput {
        return stop_stream.execute(self, allocator, input, options);
    }

    /// Adds or updates tags for the Amazon Web Services resource with the specified
    /// ARN.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from the resource with the specified ARN.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a channel's configuration. Live channels cannot be updated. You must
    /// stop the
    /// ongoing stream, update the channel, and restart the stream for the changes
    /// to take
    /// effect.
    pub fn updateChannel(self: *Self, allocator: std.mem.Allocator, input: update_channel.UpdateChannelInput, options: update_channel.Options) !update_channel.UpdateChannelOutput {
        return update_channel.execute(self, allocator, input, options);
    }

    /// Updates a specified playback restriction policy.
    pub fn updatePlaybackRestrictionPolicy(self: *Self, allocator: std.mem.Allocator, input: update_playback_restriction_policy.UpdatePlaybackRestrictionPolicyInput, options: update_playback_restriction_policy.Options) !update_playback_restriction_policy.UpdatePlaybackRestrictionPolicyOutput {
        return update_playback_restriction_policy.execute(self, allocator, input, options);
    }

    pub fn listChannelsPaginator(self: *Self, params: list_channels.ListChannelsInput) paginator.ListChannelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPlaybackKeyPairsPaginator(self: *Self, params: list_playback_key_pairs.ListPlaybackKeyPairsInput) paginator.ListPlaybackKeyPairsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listPlaybackRestrictionPoliciesPaginator(self: *Self, params: list_playback_restriction_policies.ListPlaybackRestrictionPoliciesInput) paginator.ListPlaybackRestrictionPoliciesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRecordingConfigurationsPaginator(self: *Self, params: list_recording_configurations.ListRecordingConfigurationsInput) paginator.ListRecordingConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStreamKeysPaginator(self: *Self, params: list_stream_keys.ListStreamKeysInput) paginator.ListStreamKeysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStreamSessionsPaginator(self: *Self, params: list_stream_sessions.ListStreamSessionsInput) paginator.ListStreamSessionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listStreamsPaginator(self: *Self, params: list_streams.ListStreamsInput) paginator.ListStreamsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
