const aws = @import("aws");
const std = @import("std");

const create_signaling_channel = @import("create_signaling_channel.zig");
const create_stream = @import("create_stream.zig");
const delete_edge_configuration = @import("delete_edge_configuration.zig");
const delete_signaling_channel = @import("delete_signaling_channel.zig");
const delete_stream = @import("delete_stream.zig");
const describe_edge_configuration = @import("describe_edge_configuration.zig");
const describe_image_generation_configuration = @import("describe_image_generation_configuration.zig");
const describe_mapped_resource_configuration = @import("describe_mapped_resource_configuration.zig");
const describe_media_storage_configuration = @import("describe_media_storage_configuration.zig");
const describe_notification_configuration = @import("describe_notification_configuration.zig");
const describe_signaling_channel = @import("describe_signaling_channel.zig");
const describe_stream = @import("describe_stream.zig");
const describe_stream_storage_configuration = @import("describe_stream_storage_configuration.zig");
const get_data_endpoint = @import("get_data_endpoint.zig");
const get_signaling_channel_endpoint = @import("get_signaling_channel_endpoint.zig");
const list_edge_agent_configurations = @import("list_edge_agent_configurations.zig");
const list_signaling_channels = @import("list_signaling_channels.zig");
const list_streams = @import("list_streams.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const list_tags_for_stream = @import("list_tags_for_stream.zig");
const start_edge_configuration_update = @import("start_edge_configuration_update.zig");
const tag_resource = @import("tag_resource.zig");
const tag_stream = @import("tag_stream.zig");
const untag_resource = @import("untag_resource.zig");
const untag_stream = @import("untag_stream.zig");
const update_data_retention = @import("update_data_retention.zig");
const update_image_generation_configuration = @import("update_image_generation_configuration.zig");
const update_media_storage_configuration = @import("update_media_storage_configuration.zig");
const update_notification_configuration = @import("update_notification_configuration.zig");
const update_signaling_channel = @import("update_signaling_channel.zig");
const update_stream = @import("update_stream.zig");
const update_stream_storage_configuration = @import("update_stream_storage_configuration.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Kinesis Video";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Creates a signaling channel.
    ///
    /// `CreateSignalingChannel` is an asynchronous operation.
    pub fn createSignalingChannel(self: *Self, allocator: std.mem.Allocator, input: create_signaling_channel.CreateSignalingChannelInput, options: create_signaling_channel.Options) !create_signaling_channel.CreateSignalingChannelOutput {
        return create_signaling_channel.execute(self, allocator, input, options);
    }

    /// Creates a new Kinesis video stream.
    ///
    /// When you create a new stream, Kinesis Video Streams assigns it a version
    /// number.
    /// When you change the stream's metadata, Kinesis Video Streams updates the
    /// version.
    ///
    /// `CreateStream` is an asynchronous operation.
    ///
    /// For information about how the service works, see [How it
    /// Works](https://docs.aws.amazon.com/kinesisvideostreams/latest/dg/how-it-works.html).
    ///
    /// You must have permissions for the `KinesisVideo:CreateStream`
    /// action.
    pub fn createStream(self: *Self, allocator: std.mem.Allocator, input: create_stream.CreateStreamInput, options: create_stream.Options) !create_stream.CreateStreamOutput {
        return create_stream.execute(self, allocator, input, options);
    }

    /// An asynchronous API that deletes a stream’s existing edge configuration, as
    /// well as the corresponding media from the Edge Agent.
    ///
    /// When you invoke this API, the sync status is set to `DELETING`. A deletion
    /// process starts, in which active edge jobs are stopped and all media is
    /// deleted from the edge device. The time to delete varies, depending on the
    /// total amount of stored media. If the deletion process fails, the sync status
    /// changes to `DELETE_FAILED`. You will need to re-try the deletion.
    ///
    /// When the deletion process has completed successfully, the edge configuration
    /// is no longer accessible.
    pub fn deleteEdgeConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_edge_configuration.DeleteEdgeConfigurationInput, options: delete_edge_configuration.Options) !delete_edge_configuration.DeleteEdgeConfigurationOutput {
        return delete_edge_configuration.execute(self, allocator, input, options);
    }

    /// Deletes a specified signaling channel. `DeleteSignalingChannel` is an
    /// asynchronous operation. If you don't specify the channel's current version,
    /// the most
    /// recent version is deleted.
    pub fn deleteSignalingChannel(self: *Self, allocator: std.mem.Allocator, input: delete_signaling_channel.DeleteSignalingChannelInput, options: delete_signaling_channel.Options) !delete_signaling_channel.DeleteSignalingChannelOutput {
        return delete_signaling_channel.execute(self, allocator, input, options);
    }

    /// Deletes a Kinesis video stream and the data contained in the stream.
    ///
    /// This method marks the stream for deletion, and makes the data in the stream
    /// inaccessible immediately.
    ///
    /// To ensure that you have the latest version of the stream before deleting it,
    /// you
    /// can specify the stream version. Kinesis Video Streams assigns a version to
    /// each stream.
    /// When you update a stream, Kinesis Video Streams assigns a new version
    /// number. To get the
    /// latest stream version, use the `DescribeStream` API.
    ///
    /// This operation requires permission for the `KinesisVideo:DeleteStream`
    /// action.
    pub fn deleteStream(self: *Self, allocator: std.mem.Allocator, input: delete_stream.DeleteStreamInput, options: delete_stream.Options) !delete_stream.DeleteStreamOutput {
        return delete_stream.execute(self, allocator, input, options);
    }

    /// Describes a stream’s edge configuration that was set using the
    /// `StartEdgeConfigurationUpdate` API and the latest status of the edge
    /// agent's recorder and uploader jobs. Use this API to get the status of the
    /// configuration
    /// to determine if the configuration is in sync with the Edge Agent. Use this
    /// API to
    /// evaluate the health of the Edge Agent.
    pub fn describeEdgeConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_edge_configuration.DescribeEdgeConfigurationInput, options: describe_edge_configuration.Options) !describe_edge_configuration.DescribeEdgeConfigurationOutput {
        return describe_edge_configuration.execute(self, allocator, input, options);
    }

    /// Gets the `ImageGenerationConfiguration` for a given Kinesis video stream.
    pub fn describeImageGenerationConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_image_generation_configuration.DescribeImageGenerationConfigurationInput, options: describe_image_generation_configuration.Options) !describe_image_generation_configuration.DescribeImageGenerationConfigurationOutput {
        return describe_image_generation_configuration.execute(self, allocator, input, options);
    }

    /// Returns the most current information about the stream. The `streamName`
    /// or `streamARN` should be provided in the input.
    pub fn describeMappedResourceConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_mapped_resource_configuration.DescribeMappedResourceConfigurationInput, options: describe_mapped_resource_configuration.Options) !describe_mapped_resource_configuration.DescribeMappedResourceConfigurationOutput {
        return describe_mapped_resource_configuration.execute(self, allocator, input, options);
    }

    /// Returns the most current information about the channel. Specify the
    /// `ChannelName`
    /// or `ChannelARN` in the input.
    pub fn describeMediaStorageConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_media_storage_configuration.DescribeMediaStorageConfigurationInput, options: describe_media_storage_configuration.Options) !describe_media_storage_configuration.DescribeMediaStorageConfigurationOutput {
        return describe_media_storage_configuration.execute(self, allocator, input, options);
    }

    /// Gets the `NotificationConfiguration` for a given Kinesis video stream.
    pub fn describeNotificationConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_notification_configuration.DescribeNotificationConfigurationInput, options: describe_notification_configuration.Options) !describe_notification_configuration.DescribeNotificationConfigurationOutput {
        return describe_notification_configuration.execute(self, allocator, input, options);
    }

    /// Returns the most current information about the signaling channel. You must
    /// specify
    /// either the name or the Amazon Resource Name (ARN) of the channel that you
    /// want to
    /// describe.
    pub fn describeSignalingChannel(self: *Self, allocator: std.mem.Allocator, input: describe_signaling_channel.DescribeSignalingChannelInput, options: describe_signaling_channel.Options) !describe_signaling_channel.DescribeSignalingChannelOutput {
        return describe_signaling_channel.execute(self, allocator, input, options);
    }

    /// Returns the most current information about the specified stream. You must
    /// specify
    /// either the `StreamName` or the `StreamARN`.
    pub fn describeStream(self: *Self, allocator: std.mem.Allocator, input: describe_stream.DescribeStreamInput, options: describe_stream.Options) !describe_stream.DescribeStreamOutput {
        return describe_stream.execute(self, allocator, input, options);
    }

    /// Retrieves the current storage configuration for the specified Kinesis video
    /// stream.
    ///
    /// In the request, you must specify either the `StreamName` or the `StreamARN`.
    ///
    /// You must have permissions for the
    /// `KinesisVideo:DescribeStreamStorageConfiguration` action.
    pub fn describeStreamStorageConfiguration(self: *Self, allocator: std.mem.Allocator, input: describe_stream_storage_configuration.DescribeStreamStorageConfigurationInput, options: describe_stream_storage_configuration.Options) !describe_stream_storage_configuration.DescribeStreamStorageConfigurationOutput {
        return describe_stream_storage_configuration.execute(self, allocator, input, options);
    }

    /// Gets an endpoint for a specified stream for either reading or writing. Use
    /// this
    /// endpoint in your application to read from the specified stream (using the
    /// `GetMedia` or `GetMediaForFragmentList` operations) or write
    /// to it (using the `PutMedia` operation).
    ///
    /// The returned endpoint does not have the API name appended. The client needs
    /// to
    /// add the API name to the returned endpoint.
    ///
    /// In the request, specify the stream either by `StreamName` or
    /// `StreamARN`.
    pub fn getDataEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_data_endpoint.GetDataEndpointInput, options: get_data_endpoint.Options) !get_data_endpoint.GetDataEndpointOutput {
        return get_data_endpoint.execute(self, allocator, input, options);
    }

    /// Provides an endpoint for the specified signaling channel to send and receive
    /// messages.
    /// This API uses the `SingleMasterChannelEndpointConfiguration` input
    /// parameter,
    /// which consists of the `Protocols` and `Role` properties.
    ///
    /// `Protocols` is used to determine the communication mechanism. For example,
    /// if you specify `WSS` as the protocol, this API produces a secure websocket
    /// endpoint. If you specify `HTTPS` as the protocol, this API generates an
    /// HTTPS
    /// endpoint. If you specify `WEBRTC` as the protocol, but the signaling channel
    /// isn't
    /// configured for ingestion, you will receive the error
    /// `InvalidArgumentException`.
    ///
    /// `Role` determines the messaging permissions. A `MASTER` role
    /// results in this API generating an endpoint that a client can use to
    /// communicate with any
    /// of the viewers on the channel. A `VIEWER` role results in this API
    /// generating
    /// an endpoint that a client can use to communicate only with a `MASTER`.
    pub fn getSignalingChannelEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_signaling_channel_endpoint.GetSignalingChannelEndpointInput, options: get_signaling_channel_endpoint.Options) !get_signaling_channel_endpoint.GetSignalingChannelEndpointOutput {
        return get_signaling_channel_endpoint.execute(self, allocator, input, options);
    }

    /// Returns an array of edge configurations associated with the specified Edge
    /// Agent.
    ///
    /// In the request, you must specify the Edge Agent `HubDeviceArn`.
    pub fn listEdgeAgentConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_edge_agent_configurations.ListEdgeAgentConfigurationsInput, options: list_edge_agent_configurations.Options) !list_edge_agent_configurations.ListEdgeAgentConfigurationsOutput {
        return list_edge_agent_configurations.execute(self, allocator, input, options);
    }

    /// Returns an array of `ChannelInfo` objects. Each object describes a
    /// signaling channel. To retrieve only those channels that satisfy a specific
    /// condition,
    /// you can specify a `ChannelNameCondition`.
    pub fn listSignalingChannels(self: *Self, allocator: std.mem.Allocator, input: list_signaling_channels.ListSignalingChannelsInput, options: list_signaling_channels.Options) !list_signaling_channels.ListSignalingChannelsOutput {
        return list_signaling_channels.execute(self, allocator, input, options);
    }

    /// Returns an array of `StreamInfo` objects. Each object describes a
    /// stream. To retrieve only streams that satisfy a specific condition, you can
    /// specify a
    /// `StreamNameCondition`.
    pub fn listStreams(self: *Self, allocator: std.mem.Allocator, input: list_streams.ListStreamsInput, options: list_streams.Options) !list_streams.ListStreamsOutput {
        return list_streams.execute(self, allocator, input, options);
    }

    /// Returns a list of tags associated with the specified signaling channel.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Returns a list of tags associated with the specified stream.
    ///
    /// In the request, you must specify either the `StreamName` or the
    /// `StreamARN`.
    pub fn listTagsForStream(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_stream.ListTagsForStreamInput, options: list_tags_for_stream.Options) !list_tags_for_stream.ListTagsForStreamOutput {
        return list_tags_for_stream.execute(self, allocator, input, options);
    }

    /// An asynchronous API that updates a stream’s existing edge configuration.
    /// The Kinesis Video Stream will sync the stream’s edge configuration with the
    /// Edge Agent IoT Greengrass
    /// component that runs on an IoT Hub Device, setup at your premise. The time to
    /// sync can vary
    /// and depends on the connectivity of the Hub Device.
    /// The `SyncStatus` will be updated as the edge configuration is acknowledged,
    /// and synced with the Edge Agent.
    ///
    /// If this API is invoked for the first time, a new edge configuration will be
    /// created for the stream,
    /// and the sync status will be set to `SYNCING`. You will have to wait for the
    /// sync status
    /// to reach a terminal state such as: `IN_SYNC`, or `SYNC_FAILED`, before using
    /// this API again.
    /// If you invoke this API during the syncing process, a
    /// `ResourceInUseException` will be thrown.
    /// The connectivity of the stream’s edge configuration and the Edge Agent will
    /// be retried for 15 minutes. After 15 minutes,
    /// the status will transition into the `SYNC_FAILED` state.
    ///
    /// To move an edge configuration from one device to another, use
    /// DeleteEdgeConfiguration to delete
    /// the current edge configuration. You can then invoke
    /// StartEdgeConfigurationUpdate with an updated Hub Device ARN.
    pub fn startEdgeConfigurationUpdate(self: *Self, allocator: std.mem.Allocator, input: start_edge_configuration_update.StartEdgeConfigurationUpdateInput, options: start_edge_configuration_update.Options) !start_edge_configuration_update.StartEdgeConfigurationUpdateOutput {
        return start_edge_configuration_update.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to a signaling channel. A *tag* is a
    /// key-value pair (the value is optional) that you can define and assign to
    /// Amazon Web Services resources.
    /// If you specify a tag that already exists, the tag value is replaced with the
    /// value that
    /// you specify in the request. For more information, see [Using Cost Allocation
    /// Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html) in the *Billing and Cost Management and Cost Management User
    /// Guide*.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Adds one or more tags to a stream. A *tag* is a key-value pair
    /// (the value is optional) that you can define and assign to Amazon Web
    /// Services resources. If you specify
    /// a tag that already exists, the tag value is replaced with the value that you
    /// specify in
    /// the request. For more information, see [Using Cost Allocation
    /// Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html) in the *Billing and Cost Management and Cost Management User Guide*.
    ///
    /// You must provide either the `StreamName` or the
    /// `StreamARN`.
    ///
    /// This operation requires permission for the `KinesisVideo:TagStream`
    /// action.
    ///
    /// A Kinesis video stream can support up to 50 tags.
    pub fn tagStream(self: *Self, allocator: std.mem.Allocator, input: tag_stream.TagStreamInput, options: tag_stream.Options) !tag_stream.TagStreamOutput {
        return tag_stream.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from a signaling channel. In the request, specify
    /// only a tag
    /// key or keys; don't specify the value. If you specify a tag key that does not
    /// exist, it's
    /// ignored.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Removes one or more tags from a stream. In the request, specify only a tag
    /// key or
    /// keys; don't specify the value. If you specify a tag key that does not exist,
    /// it's
    /// ignored.
    ///
    /// In the request, you must provide the `StreamName` or
    /// `StreamARN`.
    pub fn untagStream(self: *Self, allocator: std.mem.Allocator, input: untag_stream.UntagStreamInput, options: untag_stream.Options) !untag_stream.UntagStreamOutput {
        return untag_stream.execute(self, allocator, input, options);
    }

    /// Increases or decreases the stream's data retention period by the value that
    /// you
    /// specify. To indicate whether you want to increase or decrease the data
    /// retention period,
    /// specify the `Operation` parameter in the request body. In the request, you
    /// must specify either the `StreamName` or the `StreamARN`.
    ///
    /// This operation requires permission for the
    /// `KinesisVideo:UpdateDataRetention` action.
    ///
    /// Changing the data retention period affects the data in the stream as
    /// follows:
    ///
    /// * If the data retention period is increased, existing data is retained for
    /// the new retention period. For example, if the data retention period is
    /// increased
    /// from one hour to seven hours, all existing data is retained for seven
    /// hours.
    ///
    /// * If the data retention period is decreased, existing data is retained for
    /// the new retention period. For example, if the data retention period is
    /// decreased
    /// from seven hours to one hour, all existing data is retained for one hour,
    /// and
    /// any data older than one hour is deleted immediately.
    pub fn updateDataRetention(self: *Self, allocator: std.mem.Allocator, input: update_data_retention.UpdateDataRetentionInput, options: update_data_retention.Options) !update_data_retention.UpdateDataRetentionOutput {
        return update_data_retention.execute(self, allocator, input, options);
    }

    /// Updates the `StreamInfo` and `ImageProcessingConfiguration` fields.
    pub fn updateImageGenerationConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_image_generation_configuration.UpdateImageGenerationConfigurationInput, options: update_image_generation_configuration.Options) !update_image_generation_configuration.UpdateImageGenerationConfigurationOutput {
        return update_image_generation_configuration.execute(self, allocator, input, options);
    }

    /// Associates a `SignalingChannel` to a stream to store the media. There are
    /// two signaling modes that you can specify :
    ///
    /// * If `StorageStatus` is enabled, the data will be stored in the
    /// `StreamARN` provided. In order for WebRTC Ingestion to work, the stream must
    /// have data retention
    /// enabled.
    ///
    /// * If `StorageStatus` is disabled, no data will be stored, and the
    /// `StreamARN` parameter will not be needed.
    ///
    /// If `StorageStatus` is enabled, direct peer-to-peer (master-viewer)
    /// connections no
    /// longer occur. Peers connect directly to the storage session. You must call
    /// the
    /// `JoinStorageSession` API to trigger an SDP offer send and establish a
    /// connection between a peer and the storage session.
    pub fn updateMediaStorageConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_media_storage_configuration.UpdateMediaStorageConfigurationInput, options: update_media_storage_configuration.Options) !update_media_storage_configuration.UpdateMediaStorageConfigurationOutput {
        return update_media_storage_configuration.execute(self, allocator, input, options);
    }

    /// Updates the notification information for a stream.
    pub fn updateNotificationConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_notification_configuration.UpdateNotificationConfigurationInput, options: update_notification_configuration.Options) !update_notification_configuration.UpdateNotificationConfigurationOutput {
        return update_notification_configuration.execute(self, allocator, input, options);
    }

    /// Updates the existing signaling channel. This is an asynchronous operation
    /// and takes
    /// time to complete.
    ///
    /// If the `MessageTtlSeconds` value is updated (either increased or reduced),
    /// it only applies to new messages sent via this channel after it's been
    /// updated. Existing
    /// messages are still expired as per the previous `MessageTtlSeconds`
    /// value.
    pub fn updateSignalingChannel(self: *Self, allocator: std.mem.Allocator, input: update_signaling_channel.UpdateSignalingChannelInput, options: update_signaling_channel.Options) !update_signaling_channel.UpdateSignalingChannelOutput {
        return update_signaling_channel.execute(self, allocator, input, options);
    }

    /// Updates stream metadata, such as the device name and media type.
    ///
    /// You must provide the stream name or the Amazon Resource Name (ARN) of the
    /// stream.
    ///
    /// To make sure that you have the latest version of the stream before updating
    /// it, you
    /// can specify the stream version. Kinesis Video Streams assigns a version to
    /// each stream.
    /// When you update a stream, Kinesis Video Streams assigns a new version
    /// number. To get the
    /// latest stream version, use the `DescribeStream` API.
    ///
    /// `UpdateStream` is an asynchronous operation, and takes time to
    /// complete.
    pub fn updateStream(self: *Self, allocator: std.mem.Allocator, input: update_stream.UpdateStreamInput, options: update_stream.Options) !update_stream.UpdateStreamOutput {
        return update_stream.execute(self, allocator, input, options);
    }

    /// Updates the storage configuration for an existing Kinesis video stream.
    ///
    /// This operation allows you to modify the storage tier settings for a stream,
    /// enabling you to optimize storage costs and performance based on your access
    /// patterns.
    ///
    /// `UpdateStreamStorageConfiguration` is an asynchronous operation.
    ///
    /// You must have permissions for the
    /// `KinesisVideo:UpdateStreamStorageConfiguration` action.
    pub fn updateStreamStorageConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_stream_storage_configuration.UpdateStreamStorageConfigurationInput, options: update_stream_storage_configuration.Options) !update_stream_storage_configuration.UpdateStreamStorageConfigurationOutput {
        return update_stream_storage_configuration.execute(self, allocator, input, options);
    }

    pub fn describeMappedResourceConfigurationPaginator(self: *Self, params: describe_mapped_resource_configuration.DescribeMappedResourceConfigurationInput) paginator.DescribeMappedResourceConfigurationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listEdgeAgentConfigurationsPaginator(self: *Self, params: list_edge_agent_configurations.ListEdgeAgentConfigurationsInput) paginator.ListEdgeAgentConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSignalingChannelsPaginator(self: *Self, params: list_signaling_channels.ListSignalingChannelsInput) paginator.ListSignalingChannelsPaginator {
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
