const aws = @import("aws");
const std = @import("std");

const create_chat_token = @import("create_chat_token.zig");
const create_logging_configuration = @import("create_logging_configuration.zig");
const create_room = @import("create_room.zig");
const delete_logging_configuration = @import("delete_logging_configuration.zig");
const delete_message = @import("delete_message.zig");
const delete_room = @import("delete_room.zig");
const disconnect_user = @import("disconnect_user.zig");
const get_logging_configuration = @import("get_logging_configuration.zig");
const get_room = @import("get_room.zig");
const list_logging_configurations = @import("list_logging_configurations.zig");
const list_rooms = @import("list_rooms.zig");
const list_tags_for_resource = @import("list_tags_for_resource.zig");
const send_event = @import("send_event.zig");
const tag_resource = @import("tag_resource.zig");
const untag_resource = @import("untag_resource.zig");
const update_logging_configuration = @import("update_logging_configuration.zig");
const update_room = @import("update_room.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "ivschat";

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

    /// Creates an encrypted token that is used by a chat participant to establish
    /// an individual
    /// WebSocket chat connection to a room. When the token is used to connect to
    /// chat, the
    /// connection is valid for the session duration specified in the request. The
    /// token becomes
    /// invalid at the token-expiration timestamp included in the response.
    ///
    /// Use the `capabilities` field to permit an end user to send messages or
    /// moderate a room.
    ///
    /// The `attributes` field securely attaches structured data to the chat
    /// session; the data is
    /// included within each message sent by the end user and received by other
    /// participants in the
    /// room. Common use cases for attributes include passing end-user profile data
    /// like an icon,
    /// display name, colors, badges, and other display features.
    ///
    /// Encryption keys are owned by Amazon IVS Chat and never used directly by your
    /// application.
    pub fn createChatToken(self: *Self, allocator: std.mem.Allocator, input: create_chat_token.CreateChatTokenInput, options: create_chat_token.Options) !create_chat_token.CreateChatTokenOutput {
        return create_chat_token.execute(self, allocator, input, options);
    }

    /// Creates a logging configuration that allows clients to store and record sent
    /// messages.
    pub fn createLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_logging_configuration.CreateLoggingConfigurationInput, options: create_logging_configuration.Options) !create_logging_configuration.CreateLoggingConfigurationOutput {
        return create_logging_configuration.execute(self, allocator, input, options);
    }

    /// Creates a room that allows clients to connect and pass messages.
    pub fn createRoom(self: *Self, allocator: std.mem.Allocator, input: create_room.CreateRoomInput, options: create_room.Options) !create_room.CreateRoomOutput {
        return create_room.execute(self, allocator, input, options);
    }

    /// Deletes the specified logging configuration.
    pub fn deleteLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: delete_logging_configuration.DeleteLoggingConfigurationInput, options: delete_logging_configuration.Options) !delete_logging_configuration.DeleteLoggingConfigurationOutput {
        return delete_logging_configuration.execute(self, allocator, input, options);
    }

    /// Sends an event to a specific room which directs clients to delete a specific
    /// message;
    /// that is, unrender it from view and delete it from the client’s chat history.
    /// This event’s
    /// `EventName` is `aws:DELETE_MESSAGE`. This replicates the [
    /// DeleteMessage](https://docs.aws.amazon.com/ivs/latest/chatmsgapireference/actions-deletemessage-publish.html) WebSocket operation in the Amazon IVS Chat Messaging API.
    pub fn deleteMessage(self: *Self, allocator: std.mem.Allocator, input: delete_message.DeleteMessageInput, options: delete_message.Options) !delete_message.DeleteMessageOutput {
        return delete_message.execute(self, allocator, input, options);
    }

    /// Deletes the specified room.
    pub fn deleteRoom(self: *Self, allocator: std.mem.Allocator, input: delete_room.DeleteRoomInput, options: delete_room.Options) !delete_room.DeleteRoomOutput {
        return delete_room.execute(self, allocator, input, options);
    }

    /// Disconnects all connections using a specified user ID from a room. This
    /// replicates the
    /// [
    /// DisconnectUser](https://docs.aws.amazon.com/ivs/latest/chatmsgapireference/actions-disconnectuser-publish.html) WebSocket operation in the Amazon IVS Chat Messaging API.
    pub fn disconnectUser(self: *Self, allocator: std.mem.Allocator, input: disconnect_user.DisconnectUserInput, options: disconnect_user.Options) !disconnect_user.DisconnectUserOutput {
        return disconnect_user.execute(self, allocator, input, options);
    }

    /// Gets the specified logging configuration.
    pub fn getLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_logging_configuration.GetLoggingConfigurationInput, options: get_logging_configuration.Options) !get_logging_configuration.GetLoggingConfigurationOutput {
        return get_logging_configuration.execute(self, allocator, input, options);
    }

    /// Gets the specified room.
    pub fn getRoom(self: *Self, allocator: std.mem.Allocator, input: get_room.GetRoomInput, options: get_room.Options) !get_room.GetRoomOutput {
        return get_room.execute(self, allocator, input, options);
    }

    /// Gets summary information about all your logging configurations in the AWS
    /// region where
    /// the API request is processed.
    pub fn listLoggingConfigurations(self: *Self, allocator: std.mem.Allocator, input: list_logging_configurations.ListLoggingConfigurationsInput, options: list_logging_configurations.Options) !list_logging_configurations.ListLoggingConfigurationsOutput {
        return list_logging_configurations.execute(self, allocator, input, options);
    }

    /// Gets summary information about all your rooms in the AWS region where the
    /// API request is
    /// processed. Results are sorted in descending order of `updateTime`.
    pub fn listRooms(self: *Self, allocator: std.mem.Allocator, input: list_rooms.ListRoomsInput, options: list_rooms.Options) !list_rooms.ListRoomsOutput {
        return list_rooms.execute(self, allocator, input, options);
    }

    /// Gets information about AWS tags for the specified ARN.
    pub fn listTagsForResource(self: *Self, allocator: std.mem.Allocator, input: list_tags_for_resource.ListTagsForResourceInput, options: list_tags_for_resource.Options) !list_tags_for_resource.ListTagsForResourceOutput {
        return list_tags_for_resource.execute(self, allocator, input, options);
    }

    /// Sends an event to a room. Use this within your application’s business logic
    /// to send
    /// events to clients of a room; e.g., to notify clients to change the way the
    /// chat UI is
    /// rendered.
    pub fn sendEvent(self: *Self, allocator: std.mem.Allocator, input: send_event.SendEventInput, options: send_event.Options) !send_event.SendEventOutput {
        return send_event.execute(self, allocator, input, options);
    }

    /// Adds or updates tags for the AWS resource with the specified ARN.
    pub fn tagResource(self: *Self, allocator: std.mem.Allocator, input: tag_resource.TagResourceInput, options: tag_resource.Options) !tag_resource.TagResourceOutput {
        return tag_resource.execute(self, allocator, input, options);
    }

    /// Removes tags from the resource with the specified ARN.
    pub fn untagResource(self: *Self, allocator: std.mem.Allocator, input: untag_resource.UntagResourceInput, options: untag_resource.Options) !untag_resource.UntagResourceOutput {
        return untag_resource.execute(self, allocator, input, options);
    }

    /// Updates a specified logging configuration.
    pub fn updateLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: update_logging_configuration.UpdateLoggingConfigurationInput, options: update_logging_configuration.Options) !update_logging_configuration.UpdateLoggingConfigurationOutput {
        return update_logging_configuration.execute(self, allocator, input, options);
    }

    /// Updates a room’s configuration.
    pub fn updateRoom(self: *Self, allocator: std.mem.Allocator, input: update_room.UpdateRoomInput, options: update_room.Options) !update_room.UpdateRoomOutput {
        return update_room.execute(self, allocator, input, options);
    }

    pub fn listLoggingConfigurationsPaginator(self: *Self, params: list_logging_configurations.ListLoggingConfigurationsInput) paginator.ListLoggingConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listRoomsPaginator(self: *Self, params: list_rooms.ListRoomsInput) paginator.ListRoomsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
