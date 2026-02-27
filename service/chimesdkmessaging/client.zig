const aws = @import("aws");
const std = @import("std");

const associate_channel_flow = @import("associate_channel_flow.zig");
const batch_create_channel_membership = @import("batch_create_channel_membership.zig");
const channel_flow_callback = @import("channel_flow_callback.zig");
const create_channel = @import("create_channel.zig");
const create_channel_ban = @import("create_channel_ban.zig");
const create_channel_flow = @import("create_channel_flow.zig");
const create_channel_membership = @import("create_channel_membership.zig");
const create_channel_moderator = @import("create_channel_moderator.zig");
const delete_channel = @import("delete_channel.zig");
const delete_channel_ban = @import("delete_channel_ban.zig");
const delete_channel_flow = @import("delete_channel_flow.zig");
const delete_channel_membership = @import("delete_channel_membership.zig");
const delete_channel_message = @import("delete_channel_message.zig");
const delete_channel_moderator = @import("delete_channel_moderator.zig");
const delete_messaging_streaming_configurations = @import("delete_messaging_streaming_configurations.zig");
const describe_channel = @import("describe_channel.zig");
const describe_channel_ban = @import("describe_channel_ban.zig");
const describe_channel_flow = @import("describe_channel_flow.zig");
const describe_channel_membership = @import("describe_channel_membership.zig");
const describe_channel_membership_for_app_instance_user = @import("describe_channel_membership_for_app_instance_user.zig");
const describe_channel_moderated_by_app_instance_user = @import("describe_channel_moderated_by_app_instance_user.zig");
const describe_channel_moderator = @import("describe_channel_moderator.zig");
const disassociate_channel_flow = @import("disassociate_channel_flow.zig");
const get_channel_membership_preferences = @import("get_channel_membership_preferences.zig");
const get_channel_message = @import("get_channel_message.zig");
const get_channel_message_status = @import("get_channel_message_status.zig");
const get_messaging_session_endpoint = @import("get_messaging_session_endpoint.zig");
const get_messaging_streaming_configurations = @import("get_messaging_streaming_configurations.zig");
const list_channel_bans = @import("list_channel_bans.zig");
const list_channel_flows = @import("list_channel_flows.zig");
const list_channel_memberships = @import("list_channel_memberships.zig");
const list_channel_memberships_for_app_instance_user = @import("list_channel_memberships_for_app_instance_user.zig");
const list_channel_messages = @import("list_channel_messages.zig");
const list_channel_moderators = @import("list_channel_moderators.zig");
const list_channels = @import("list_channels.zig");
const list_channels_associated_with_channel_flow = @import("list_channels_associated_with_channel_flow.zig");
const list_channels_moderated_by_app_instance_user = @import("list_channels_moderated_by_app_instance_user.zig");
const list_sub_channels = @import("list_sub_channels.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const put_channel_expiration_settings = @import("put_channel_expiration_settings.zig");
const put_channel_membership_preferences = @import("put_channel_membership_preferences.zig");
const put_messaging_streaming_configurations = @import("put_messaging_streaming_configurations.zig");
const redact_channel_message = @import("redact_channel_message.zig");
const search_channels = @import("search_channels.zig");
const send_channel_message = @import("send_channel_message.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_channel = @import("update_channel.zig");
const update_channel_flow = @import("update_channel_flow.zig");
const update_channel_message = @import("update_channel_message.zig");
const update_channel_read_marker = @import("update_channel_read_marker.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "Chime SDK Messaging";

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

    /// Associates a channel flow with a channel. Once associated, all messages to
    /// that channel go through channel flow processors. To stop processing, use the
    /// `DisassociateChannelFlow` API.
    ///
    /// Only administrators or channel moderators can associate a channel flow. The
    /// `x-amz-chime-bearer` request header is mandatory. Use the ARN of the
    /// `AppInstanceUser` or `AppInstanceBot`
    /// that makes the API call as the value in the header.
    pub fn associateChannelFlow(self: *Self, allocator: std.mem.Allocator, input: associate_channel_flow.AssociateChannelFlowInput, options: associate_channel_flow.Options) !associate_channel_flow.AssociateChannelFlowOutput {
        return associate_channel_flow.execute(self, allocator, input, options);
    }

    /// Adds a specified number of users and bots to a channel.
    pub fn batchCreateChannelMembership(self: *Self, allocator: std.mem.Allocator, input: batch_create_channel_membership.BatchCreateChannelMembershipInput, options: batch_create_channel_membership.Options) !batch_create_channel_membership.BatchCreateChannelMembershipOutput {
        return batch_create_channel_membership.execute(self, allocator, input, options);
    }

    /// Calls back Amazon Chime SDK messaging with a processing response message.
    /// This should be invoked from the processor Lambda. This is a developer API.
    ///
    /// You can return one of the following processing responses:
    ///
    /// * Update message content or metadata
    ///
    /// * Deny a message
    ///
    /// * Make no changes to the message
    pub fn channelFlowCallback(self: *Self, allocator: std.mem.Allocator, input: channel_flow_callback.ChannelFlowCallbackInput, options: channel_flow_callback.Options) !channel_flow_callback.ChannelFlowCallbackOutput {
        return channel_flow_callback.execute(self, allocator, input, options);
    }

    /// Creates a channel to which you can add users and send messages.
    ///
    /// **Restriction**: You can't change a channel's
    /// privacy.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn createChannel(self: *Self, allocator: std.mem.Allocator, input: create_channel.CreateChannelInput, options: create_channel.Options) !create_channel.CreateChannelOutput {
        return create_channel.execute(self, allocator, input, options);
    }

    /// Permanently bans a member from a channel. Moderators can't add banned
    /// members to a
    /// channel. To undo a ban, you first have to `DeleteChannelBan`, and then
    /// `CreateChannelMembership`. Bans are cleaned up when you delete users or
    /// channels.
    ///
    /// If you ban a user who is already part of a channel, that user is
    /// automatically kicked
    /// from the channel.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn createChannelBan(self: *Self, allocator: std.mem.Allocator, input: create_channel_ban.CreateChannelBanInput, options: create_channel_ban.Options) !create_channel_ban.CreateChannelBanOutput {
        return create_channel_ban.execute(self, allocator, input, options);
    }

    /// Creates a channel flow, a container for processors. Processors are AWS
    /// Lambda functions
    /// that perform actions on chat messages, such as stripping out profanity. You
    /// can associate
    /// channel flows with channels, and the processors in the channel flow then
    /// take action on all
    /// messages sent to that channel. This is a developer API.
    ///
    /// Channel flows process the following items:
    ///
    /// * New and updated messages
    ///
    /// * Persistent and non-persistent messages
    ///
    /// * The Standard message type
    ///
    /// Channel flows don't process Control or System messages. For more information
    /// about the message types provided by Chime SDK messaging, refer to
    /// [Message
    /// types](https://docs.aws.amazon.com/chime-sdk/latest/dg/using-the-messaging-sdk.html#msg-types) in the *Amazon Chime developer guide*.
    pub fn createChannelFlow(self: *Self, allocator: std.mem.Allocator, input: create_channel_flow.CreateChannelFlowInput, options: create_channel_flow.Options) !create_channel_flow.CreateChannelFlowOutput {
        return create_channel_flow.execute(self, allocator, input, options);
    }

    /// Adds a member to a channel. The `InvitedBy` field in `ChannelMembership`
    /// is derived from the request header. A channel member can:
    ///
    /// * List messages
    ///
    /// * Send messages
    ///
    /// * Receive messages
    ///
    /// * Edit their own messages
    ///
    /// * Leave the channel
    ///
    /// Privacy settings impact this action as follows:
    ///
    /// * Public Channels: You do not need to be a member to list messages, but you
    ///   must be
    /// a member to send messages.
    ///
    /// * Private Channels: You must be a member to list or send messages.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUserArn` or `AppInstanceBot` that makes the API call
    /// as the value in the header.
    pub fn createChannelMembership(self: *Self, allocator: std.mem.Allocator, input: create_channel_membership.CreateChannelMembershipInput, options: create_channel_membership.Options) !create_channel_membership.CreateChannelMembershipOutput {
        return create_channel_membership.execute(self, allocator, input, options);
    }

    /// Creates a new `ChannelModerator`. A channel moderator can:
    ///
    /// * Add and remove other members of the channel.
    ///
    /// * Add and remove other moderators of the channel.
    ///
    /// * Add and remove user bans for the channel.
    ///
    /// * Redact messages in the channel.
    ///
    /// * List messages in the channel.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot`of the user that makes the
    /// API call as the value in
    /// the header.
    pub fn createChannelModerator(self: *Self, allocator: std.mem.Allocator, input: create_channel_moderator.CreateChannelModeratorInput, options: create_channel_moderator.Options) !create_channel_moderator.CreateChannelModeratorOutput {
        return create_channel_moderator.execute(self, allocator, input, options);
    }

    /// Immediately makes a channel and its memberships inaccessible and marks them
    /// for
    /// deletion. This is an irreversible process.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUserArn` or `AppInstanceBot` that makes the API call
    /// as the value in
    /// the header.
    pub fn deleteChannel(self: *Self, allocator: std.mem.Allocator, input: delete_channel.DeleteChannelInput, options: delete_channel.Options) !delete_channel.DeleteChannelOutput {
        return delete_channel.execute(self, allocator, input, options);
    }

    /// Removes a member from a channel's ban list.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn deleteChannelBan(self: *Self, allocator: std.mem.Allocator, input: delete_channel_ban.DeleteChannelBanInput, options: delete_channel_ban.Options) !delete_channel_ban.DeleteChannelBanOutput {
        return delete_channel_ban.execute(self, allocator, input, options);
    }

    /// Deletes a channel flow, an irreversible process. This is a developer API.
    ///
    /// This API works only when the channel flow is not associated with any
    /// channel. To get a list of all channels that a channel flow is associated
    /// with, use the
    /// `ListChannelsAssociatedWithChannelFlow` API. Use the
    /// `DisassociateChannelFlow` API to disassociate a channel flow from all
    /// channels.
    pub fn deleteChannelFlow(self: *Self, allocator: std.mem.Allocator, input: delete_channel_flow.DeleteChannelFlowInput, options: delete_channel_flow.Options) !delete_channel_flow.DeleteChannelFlowOutput {
        return delete_channel_flow.execute(self, allocator, input, options);
    }

    /// Removes a member from a channel.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// `AppInstanceUserArn` of the user that makes the API call as the value in
    /// the header.
    pub fn deleteChannelMembership(self: *Self, allocator: std.mem.Allocator, input: delete_channel_membership.DeleteChannelMembershipInput, options: delete_channel_membership.Options) !delete_channel_membership.DeleteChannelMembershipOutput {
        return delete_channel_membership.execute(self, allocator, input, options);
    }

    /// Deletes a channel message. Only admins can perform this action. Deletion
    /// makes messages
    /// inaccessible immediately. A background process deletes any revisions created
    /// by
    /// `UpdateChannelMessage`.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn deleteChannelMessage(self: *Self, allocator: std.mem.Allocator, input: delete_channel_message.DeleteChannelMessageInput, options: delete_channel_message.Options) !delete_channel_message.DeleteChannelMessageOutput {
        return delete_channel_message.execute(self, allocator, input, options);
    }

    /// Deletes a channel moderator.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn deleteChannelModerator(self: *Self, allocator: std.mem.Allocator, input: delete_channel_moderator.DeleteChannelModeratorInput, options: delete_channel_moderator.Options) !delete_channel_moderator.DeleteChannelModeratorOutput {
        return delete_channel_moderator.execute(self, allocator, input, options);
    }

    /// Deletes the streaming configurations for an `AppInstance`. For more
    /// information, see
    /// [Streaming messaging
    /// data](https://docs.aws.amazon.com/chime-sdk/latest/dg/streaming-export.html)
    /// in the *Amazon Chime SDK Developer Guide*.
    pub fn deleteMessagingStreamingConfigurations(self: *Self, allocator: std.mem.Allocator, input: delete_messaging_streaming_configurations.DeleteMessagingStreamingConfigurationsInput, options: delete_messaging_streaming_configurations.Options) !delete_messaging_streaming_configurations.DeleteMessagingStreamingConfigurationsOutput {
        return delete_messaging_streaming_configurations.execute(self, allocator, input, options);
    }

    /// Returns the full details of a channel in an Amazon Chime
    /// `AppInstance`.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn describeChannel(self: *Self, allocator: std.mem.Allocator, input: describe_channel.DescribeChannelInput, options: describe_channel.Options) !describe_channel.DescribeChannelOutput {
        return describe_channel.execute(self, allocator, input, options);
    }

    /// Returns the full details of a channel ban.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn describeChannelBan(self: *Self, allocator: std.mem.Allocator, input: describe_channel_ban.DescribeChannelBanInput, options: describe_channel_ban.Options) !describe_channel_ban.DescribeChannelBanOutput {
        return describe_channel_ban.execute(self, allocator, input, options);
    }

    /// Returns the full details of a channel flow in an Amazon Chime `AppInstance`.
    /// This is a developer API.
    pub fn describeChannelFlow(self: *Self, allocator: std.mem.Allocator, input: describe_channel_flow.DescribeChannelFlowInput, options: describe_channel_flow.Options) !describe_channel_flow.DescribeChannelFlowOutput {
        return describe_channel_flow.execute(self, allocator, input, options);
    }

    /// Returns the full details of a user's channel membership.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn describeChannelMembership(self: *Self, allocator: std.mem.Allocator, input: describe_channel_membership.DescribeChannelMembershipInput, options: describe_channel_membership.Options) !describe_channel_membership.DescribeChannelMembershipOutput {
        return describe_channel_membership.execute(self, allocator, input, options);
    }

    /// Returns the details of a channel based on the membership of the specified
    /// `AppInstanceUser` or `AppInstanceBot`.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn describeChannelMembershipForAppInstanceUser(self: *Self, allocator: std.mem.Allocator, input: describe_channel_membership_for_app_instance_user.DescribeChannelMembershipForAppInstanceUserInput, options: describe_channel_membership_for_app_instance_user.Options) !describe_channel_membership_for_app_instance_user.DescribeChannelMembershipForAppInstanceUserOutput {
        return describe_channel_membership_for_app_instance_user.execute(self, allocator, input, options);
    }

    /// Returns the full details of a channel moderated by the specified
    /// `AppInstanceUser` or `AppInstanceBot`.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn describeChannelModeratedByAppInstanceUser(self: *Self, allocator: std.mem.Allocator, input: describe_channel_moderated_by_app_instance_user.DescribeChannelModeratedByAppInstanceUserInput, options: describe_channel_moderated_by_app_instance_user.Options) !describe_channel_moderated_by_app_instance_user.DescribeChannelModeratedByAppInstanceUserOutput {
        return describe_channel_moderated_by_app_instance_user.execute(self, allocator, input, options);
    }

    /// Returns the full details of a single ChannelModerator.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// `AppInstanceUserArn` of the user that makes the API call as the value in
    /// the header.
    pub fn describeChannelModerator(self: *Self, allocator: std.mem.Allocator, input: describe_channel_moderator.DescribeChannelModeratorInput, options: describe_channel_moderator.Options) !describe_channel_moderator.DescribeChannelModeratorOutput {
        return describe_channel_moderator.execute(self, allocator, input, options);
    }

    /// Disassociates a channel flow from all its channels. Once disassociated, all
    /// messages to
    /// that channel stop going through the channel flow processor.
    ///
    /// Only administrators or channel moderators can disassociate a channel flow.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn disassociateChannelFlow(self: *Self, allocator: std.mem.Allocator, input: disassociate_channel_flow.DisassociateChannelFlowInput, options: disassociate_channel_flow.Options) !disassociate_channel_flow.DisassociateChannelFlowOutput {
        return disassociate_channel_flow.execute(self, allocator, input, options);
    }

    /// Gets the membership preferences of an `AppInstanceUser` or `AppInstanceBot`
    /// for the specified channel. A user or a bot must be a member of the channel
    /// and own the membership in order to retrieve membership preferences.
    /// Users or bots in the `AppInstanceAdmin` and channel moderator roles can't
    /// retrieve preferences for other users or bots. Banned users or bots can't
    /// retrieve membership preferences for the
    /// channel from which they are banned.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn getChannelMembershipPreferences(self: *Self, allocator: std.mem.Allocator, input: get_channel_membership_preferences.GetChannelMembershipPreferencesInput, options: get_channel_membership_preferences.Options) !get_channel_membership_preferences.GetChannelMembershipPreferencesOutput {
        return get_channel_membership_preferences.execute(self, allocator, input, options);
    }

    /// Gets the full details of a channel message.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn getChannelMessage(self: *Self, allocator: std.mem.Allocator, input: get_channel_message.GetChannelMessageInput, options: get_channel_message.Options) !get_channel_message.GetChannelMessageOutput {
        return get_channel_message.execute(self, allocator, input, options);
    }

    /// Gets message status for a specified `messageId`. Use this API to determine
    /// the intermediate status of messages going through channel flow processing.
    /// The API provides an alternative to
    /// retrieving message status if the event was not received because a client
    /// wasn't connected to a websocket.
    ///
    /// Messages can have any one of these statuses.
    ///
    /// **SENT**
    ///
    /// Message processed successfully
    ///
    /// **PENDING**
    ///
    /// Ongoing processing
    ///
    /// **FAILED**
    ///
    /// Processing failed
    ///
    /// **DENIED**
    ///
    /// Message denied by the processor
    ///
    /// * This API does not return statuses for denied messages, because we don't
    ///   store them once the processor denies them.
    ///
    /// * Only the message sender can invoke this API.
    ///
    /// * The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn getChannelMessageStatus(self: *Self, allocator: std.mem.Allocator, input: get_channel_message_status.GetChannelMessageStatusInput, options: get_channel_message_status.Options) !get_channel_message_status.GetChannelMessageStatusOutput {
        return get_channel_message_status.execute(self, allocator, input, options);
    }

    /// The details of the endpoint for the messaging session.
    pub fn getMessagingSessionEndpoint(self: *Self, allocator: std.mem.Allocator, input: get_messaging_session_endpoint.GetMessagingSessionEndpointInput, options: get_messaging_session_endpoint.Options) !get_messaging_session_endpoint.GetMessagingSessionEndpointOutput {
        return get_messaging_session_endpoint.execute(self, allocator, input, options);
    }

    /// Retrieves the data streaming configuration for an `AppInstance`. For more
    /// information, see
    /// [Streaming messaging
    /// data](https://docs.aws.amazon.com/chime-sdk/latest/dg/streaming-export.html)
    /// in the *Amazon Chime SDK Developer Guide*.
    pub fn getMessagingStreamingConfigurations(self: *Self, allocator: std.mem.Allocator, input: get_messaging_streaming_configurations.GetMessagingStreamingConfigurationsInput, options: get_messaging_streaming_configurations.Options) !get_messaging_streaming_configurations.GetMessagingStreamingConfigurationsOutput {
        return get_messaging_streaming_configurations.execute(self, allocator, input, options);
    }

    /// Lists all the users and bots banned from a particular channel.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn listChannelBans(self: *Self, allocator: std.mem.Allocator, input: list_channel_bans.ListChannelBansInput, options: list_channel_bans.Options) !list_channel_bans.ListChannelBansOutput {
        return list_channel_bans.execute(self, allocator, input, options);
    }

    /// Returns a paginated lists of all the channel flows created under a single
    /// Chime. This is a developer API.
    pub fn listChannelFlows(self: *Self, allocator: std.mem.Allocator, input: list_channel_flows.ListChannelFlowsInput, options: list_channel_flows.Options) !list_channel_flows.ListChannelFlowsOutput {
        return list_channel_flows.execute(self, allocator, input, options);
    }

    /// Lists all channel memberships in a channel.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    ///
    /// If you want to list the channels to which a specific app instance user
    /// belongs, see the
    /// [ListChannelMembershipsForAppInstanceUser](https://docs.aws.amazon.com/chime-sdk/latest/APIReference/API_messaging-chime_ListChannelMembershipsForAppInstanceUser.html) API.
    pub fn listChannelMemberships(self: *Self, allocator: std.mem.Allocator, input: list_channel_memberships.ListChannelMembershipsInput, options: list_channel_memberships.Options) !list_channel_memberships.ListChannelMembershipsOutput {
        return list_channel_memberships.execute(self, allocator, input, options);
    }

    /// Lists all channels that an `AppInstanceUser` or `AppInstanceBot` is a part
    /// of.
    /// Only an `AppInstanceAdmin` can call the API with a user ARN that is not
    /// their own.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn listChannelMembershipsForAppInstanceUser(self: *Self, allocator: std.mem.Allocator, input: list_channel_memberships_for_app_instance_user.ListChannelMembershipsForAppInstanceUserInput, options: list_channel_memberships_for_app_instance_user.Options) !list_channel_memberships_for_app_instance_user.ListChannelMembershipsForAppInstanceUserOutput {
        return list_channel_memberships_for_app_instance_user.execute(self, allocator, input, options);
    }

    /// List all the messages in a channel. Returns a paginated list of
    /// `ChannelMessages`. By default, sorted by creation timestamp in descending
    /// order.
    ///
    /// Redacted messages appear in the results as empty, since they are only
    /// redacted, not
    /// deleted. Deleted messages do not appear in the results. This action always
    /// returns the
    /// latest version of an edited message.
    ///
    /// Also, the `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn listChannelMessages(self: *Self, allocator: std.mem.Allocator, input: list_channel_messages.ListChannelMessagesInput, options: list_channel_messages.Options) !list_channel_messages.ListChannelMessagesOutput {
        return list_channel_messages.execute(self, allocator, input, options);
    }

    /// Lists all the moderators for a channel.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn listChannelModerators(self: *Self, allocator: std.mem.Allocator, input: list_channel_moderators.ListChannelModeratorsInput, options: list_channel_moderators.Options) !list_channel_moderators.ListChannelModeratorsOutput {
        return list_channel_moderators.execute(self, allocator, input, options);
    }

    /// Lists all Channels created under a single Chime App as a paginated list. You
    /// can specify
    /// filters to narrow results.
    ///
    /// **Functionality & restrictions**
    ///
    /// * Use privacy = `PUBLIC` to retrieve all public channels in the
    /// account.
    ///
    /// * Only an `AppInstanceAdmin` can set privacy = `PRIVATE` to
    /// list the private channels in an account.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn listChannels(self: *Self, allocator: std.mem.Allocator, input: list_channels.ListChannelsInput, options: list_channels.Options) !list_channels.ListChannelsOutput {
        return list_channels.execute(self, allocator, input, options);
    }

    /// Lists all channels associated with a specified channel flow. You can
    /// associate a channel flow with multiple channels, but you can only associate
    /// a channel with one channel flow. This is a developer API.
    pub fn listChannelsAssociatedWithChannelFlow(self: *Self, allocator: std.mem.Allocator, input: list_channels_associated_with_channel_flow.ListChannelsAssociatedWithChannelFlowInput, options: list_channels_associated_with_channel_flow.Options) !list_channels_associated_with_channel_flow.ListChannelsAssociatedWithChannelFlowOutput {
        return list_channels_associated_with_channel_flow.execute(self, allocator, input, options);
    }

    /// A list of the channels moderated by an `AppInstanceUser`.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn listChannelsModeratedByAppInstanceUser(self: *Self, allocator: std.mem.Allocator, input: list_channels_moderated_by_app_instance_user.ListChannelsModeratedByAppInstanceUserInput, options: list_channels_moderated_by_app_instance_user.Options) !list_channels_moderated_by_app_instance_user.ListChannelsModeratedByAppInstanceUserOutput {
        return list_channels_moderated_by_app_instance_user.execute(self, allocator, input, options);
    }

    /// Lists all the SubChannels in an elastic channel when given a channel ID.
    /// Available only to the app instance admins and channel moderators of elastic
    /// channels.
    pub fn listSubChannels(self: *Self, allocator: std.mem.Allocator, input: list_sub_channels.ListSubChannelsInput, options: list_sub_channels.Options) !list_sub_channels.ListSubChannelsOutput {
        return list_sub_channels.execute(self, allocator, input, options);
    }

    /// Lists the tags applied to an Amazon Chime SDK messaging resource.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Sets the number of days before the channel is automatically deleted.
    ///
    /// * A background process deletes expired channels within 6 hours of
    ///   expiration.
    /// Actual deletion times may vary.
    ///
    /// * Expired channels that have not yet been deleted appear as active, and you
    ///   can update
    /// their expiration settings. The system honors the new settings.
    ///
    /// * The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn putChannelExpirationSettings(self: *Self, allocator: std.mem.Allocator, input: put_channel_expiration_settings.PutChannelExpirationSettingsInput, options: put_channel_expiration_settings.Options) !put_channel_expiration_settings.PutChannelExpirationSettingsOutput {
        return put_channel_expiration_settings.execute(self, allocator, input, options);
    }

    /// Sets the membership preferences of an `AppInstanceUser` or `AppInstanceBot`
    /// for the specified channel. The user or bot must be a member of the channel.
    /// Only the user or bot who owns the
    /// membership can set preferences. Users or bots in the `AppInstanceAdmin` and
    /// channel moderator roles can't set
    /// preferences for other users. Banned users or bots can't set membership
    /// preferences for the channel from
    /// which they are banned.
    ///
    /// The x-amz-chime-bearer request header is mandatory. Use the ARN of an
    /// `AppInstanceUser` or `AppInstanceBot` that makes the API call as the value
    /// in the
    /// header.
    pub fn putChannelMembershipPreferences(self: *Self, allocator: std.mem.Allocator, input: put_channel_membership_preferences.PutChannelMembershipPreferencesInput, options: put_channel_membership_preferences.Options) !put_channel_membership_preferences.PutChannelMembershipPreferencesOutput {
        return put_channel_membership_preferences.execute(self, allocator, input, options);
    }

    /// Sets the data streaming configuration for an `AppInstance`. For more
    /// information, see
    /// [Streaming messaging
    /// data](https://docs.aws.amazon.com/chime-sdk/latest/dg/streaming-export.html)
    /// in the *Amazon Chime SDK Developer Guide*.
    pub fn putMessagingStreamingConfigurations(self: *Self, allocator: std.mem.Allocator, input: put_messaging_streaming_configurations.PutMessagingStreamingConfigurationsInput, options: put_messaging_streaming_configurations.Options) !put_messaging_streaming_configurations.PutMessagingStreamingConfigurationsOutput {
        return put_messaging_streaming_configurations.execute(self, allocator, input, options);
    }

    /// Redacts message content and metadata. The message exists in the back end,
    /// but the
    /// action returns null content, and the state shows as redacted.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn redactChannelMessage(self: *Self, allocator: std.mem.Allocator, input: redact_channel_message.RedactChannelMessageInput, options: redact_channel_message.Options) !redact_channel_message.RedactChannelMessageOutput {
        return redact_channel_message.execute(self, allocator, input, options);
    }

    /// Allows the `ChimeBearer` to search channels by channel members. Users or
    /// bots can search
    /// across the channels that they belong to. Users in the `AppInstanceAdmin`
    /// role can search across
    /// all channels.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    ///
    /// This operation isn't supported for `AppInstanceUsers` with a large number of
    /// memberships.
    pub fn searchChannels(self: *Self, allocator: std.mem.Allocator, input: search_channels.SearchChannelsInput, options: search_channels.Options) !search_channels.SearchChannelsOutput {
        return search_channels.execute(self, allocator, input, options);
    }

    /// Sends a message to a particular channel that the member is a part of.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    ///
    /// Also, `STANDARD` messages can be up to 4KB in size and contain metadata.
    /// Metadata is arbitrary,
    /// and you can use it in a variety of ways, such as containing a link to an
    /// attachment.
    ///
    /// `CONTROL` messages are limited to 30 bytes and do not contain metadata.
    pub fn sendChannelMessage(self: *Self, allocator: std.mem.Allocator, input: send_channel_message.SendChannelMessageInput, options: send_channel_message.Options) !send_channel_message.SendChannelMessageOutput {
        return send_channel_message.execute(self, allocator, input, options);
    }

    /// Applies the specified tags to the specified Amazon Chime SDK messaging
    /// resource.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes the specified tags from the specified Amazon Chime SDK messaging
    /// resource.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Update a channel's attributes.
    ///
    /// **Restriction**: You can't change a channel's privacy.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn updateChannel(self: *Self, allocator: std.mem.Allocator, input: update_channel.UpdateChannelInput, options: update_channel.Options) !update_channel.UpdateChannelOutput {
        return update_channel.execute(self, allocator, input, options);
    }

    /// Updates channel flow attributes. This is a developer API.
    pub fn updateChannelFlow(self: *Self, allocator: std.mem.Allocator, input: update_channel_flow.UpdateChannelFlowInput, options: update_channel_flow.Options) !update_channel_flow.UpdateChannelFlowOutput {
        return update_channel_flow.execute(self, allocator, input, options);
    }

    /// Updates the content of a message.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn updateChannelMessage(self: *Self, allocator: std.mem.Allocator, input: update_channel_message.UpdateChannelMessageInput, options: update_channel_message.Options) !update_channel_message.UpdateChannelMessageOutput {
        return update_channel_message.execute(self, allocator, input, options);
    }

    /// The details of the time when a user last read messages in a channel.
    ///
    /// The `x-amz-chime-bearer` request header is mandatory. Use the
    /// ARN of the `AppInstanceUser` or `AppInstanceBot` that makes the API call as
    /// the value in
    /// the header.
    pub fn updateChannelReadMarker(self: *Self, allocator: std.mem.Allocator, input: update_channel_read_marker.UpdateChannelReadMarkerInput, options: update_channel_read_marker.Options) !update_channel_read_marker.UpdateChannelReadMarkerOutput {
        return update_channel_read_marker.execute(self, allocator, input, options);
    }

    pub fn listChannelBansPaginator(self: *Self, params: list_channel_bans.ListChannelBansInput) paginator.ListChannelBansPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listChannelFlowsPaginator(self: *Self, params: list_channel_flows.ListChannelFlowsInput) paginator.ListChannelFlowsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listChannelMembershipsPaginator(self: *Self, params: list_channel_memberships.ListChannelMembershipsInput) paginator.ListChannelMembershipsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listChannelMembershipsForAppInstanceUserPaginator(self: *Self, params: list_channel_memberships_for_app_instance_user.ListChannelMembershipsForAppInstanceUserInput) paginator.ListChannelMembershipsForAppInstanceUserPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listChannelMessagesPaginator(self: *Self, params: list_channel_messages.ListChannelMessagesInput) paginator.ListChannelMessagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listChannelModeratorsPaginator(self: *Self, params: list_channel_moderators.ListChannelModeratorsInput) paginator.ListChannelModeratorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listChannelsPaginator(self: *Self, params: list_channels.ListChannelsInput) paginator.ListChannelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listChannelsAssociatedWithChannelFlowPaginator(self: *Self, params: list_channels_associated_with_channel_flow.ListChannelsAssociatedWithChannelFlowInput) paginator.ListChannelsAssociatedWithChannelFlowPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listChannelsModeratedByAppInstanceUserPaginator(self: *Self, params: list_channels_moderated_by_app_instance_user.ListChannelsModeratedByAppInstanceUserInput) paginator.ListChannelsModeratedByAppInstanceUserPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSubChannelsPaginator(self: *Self, params: list_sub_channels.ListSubChannelsInput) paginator.ListSubChannelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchChannelsPaginator(self: *Self, params: search_channels.SearchChannelsInput) paginator.SearchChannelsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
