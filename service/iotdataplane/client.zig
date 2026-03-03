const aws = @import("aws");
const std = @import("std");

const delete_connection = @import("delete_connection.zig");
const delete_thing_shadow = @import("delete_thing_shadow.zig");
const get_retained_message = @import("get_retained_message.zig");
const get_thing_shadow = @import("get_thing_shadow.zig");
const list_named_shadows_for_thing = @import("list_named_shadows_for_thing.zig");
const list_retained_messages = @import("list_retained_messages.zig");
const publish_ = @import("publish.zig");
const update_thing_shadow = @import("update_thing_shadow.zig");
const paginator = @import("paginator.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "IoT Data Plane";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, config.retry_mode),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.initWithOptions(allocator, config.retry_mode, options),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Disconnects a connected MQTT client from Amazon Web Services IoT Core. When
    /// you disconnect a client, Amazon Web Services IoT Core closes the client's
    /// network connection and optionally cleans the session state.
    pub fn deleteConnection(self: *Self, allocator: std.mem.Allocator, input: delete_connection.DeleteConnectionInput, options: delete_connection.Options) !delete_connection.DeleteConnectionOutput {
        return delete_connection.execute(self, allocator, input, options);
    }

    /// Deletes the shadow for the specified thing.
    ///
    /// Requires permission to access the
    /// [DeleteThingShadow](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    ///
    /// For more information, see
    /// [DeleteThingShadow](http://docs.aws.amazon.com/iot/latest/developerguide/API_DeleteThingShadow.html) in the IoT Developer Guide.
    pub fn deleteThingShadow(self: *Self, allocator: std.mem.Allocator, input: delete_thing_shadow.DeleteThingShadowInput, options: delete_thing_shadow.Options) !delete_thing_shadow.DeleteThingShadowOutput {
        return delete_thing_shadow.execute(self, allocator, input, options);
    }

    /// Gets the details of a single retained message for the specified topic.
    ///
    /// This action returns the message payload of the retained message, which can
    /// incur messaging costs. To list only the topic names of the retained
    /// messages, call
    /// [ListRetainedMessages](https://docs.aws.amazon.com/iot/latest/apireference/API_iotdata_ListRetainedMessages.html).
    ///
    /// Requires permission to access the
    /// [GetRetainedMessage](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html) action.
    ///
    /// For more information about messaging costs, see [Amazon Web Services IoT
    /// Core
    /// pricing - Messaging](http://aws.amazon.com/iot-core/pricing/#Messaging).
    pub fn getRetainedMessage(self: *Self, allocator: std.mem.Allocator, input: get_retained_message.GetRetainedMessageInput, options: get_retained_message.Options) !get_retained_message.GetRetainedMessageOutput {
        return get_retained_message.execute(self, allocator, input, options);
    }

    /// Gets the shadow for the specified thing.
    ///
    /// Requires permission to access the
    /// [GetThingShadow](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    ///
    /// For more information, see
    /// [GetThingShadow](http://docs.aws.amazon.com/iot/latest/developerguide/API_GetThingShadow.html) in the
    /// IoT Developer Guide.
    pub fn getThingShadow(self: *Self, allocator: std.mem.Allocator, input: get_thing_shadow.GetThingShadowInput, options: get_thing_shadow.Options) !get_thing_shadow.GetThingShadowOutput {
        return get_thing_shadow.execute(self, allocator, input, options);
    }

    /// Lists the shadows for the specified thing.
    ///
    /// Requires permission to access the
    /// [ListNamedShadowsForThing](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    pub fn listNamedShadowsForThing(self: *Self, allocator: std.mem.Allocator, input: list_named_shadows_for_thing.ListNamedShadowsForThingInput, options: list_named_shadows_for_thing.Options) !list_named_shadows_for_thing.ListNamedShadowsForThingOutput {
        return list_named_shadows_for_thing.execute(self, allocator, input, options);
    }

    /// Lists summary information about the retained messages stored for the
    /// account.
    ///
    /// This action returns only the topic names of the retained messages. It
    /// doesn't
    /// return any message payloads. Although this action doesn't return a message
    /// payload,
    /// it can still incur messaging costs.
    ///
    /// To get the message payload of a retained message, call
    /// [GetRetainedMessage](https://docs.aws.amazon.com/iot/latest/apireference/API_iotdata_GetRetainedMessage.html)
    /// with the topic name of the retained message.
    ///
    /// Requires permission to access the
    /// [ListRetainedMessages](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html) action.
    ///
    /// For more information about messaging costs, see [Amazon Web Services IoT
    /// Core
    /// pricing - Messaging](http://aws.amazon.com/iot-core/pricing/#Messaging).
    pub fn listRetainedMessages(self: *Self, allocator: std.mem.Allocator, input: list_retained_messages.ListRetainedMessagesInput, options: list_retained_messages.Options) !list_retained_messages.ListRetainedMessagesOutput {
        return list_retained_messages.execute(self, allocator, input, options);
    }

    /// Publishes an MQTT message.
    ///
    /// Requires permission to access the
    /// [Publish](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    ///
    /// For more information about MQTT messages, see
    /// [MQTT
    /// Protocol](http://docs.aws.amazon.com/iot/latest/developerguide/mqtt.html) in
    /// the
    /// IoT Developer Guide.
    ///
    /// For more information about messaging costs, see [Amazon Web Services IoT
    /// Core
    /// pricing - Messaging](http://aws.amazon.com/iot-core/pricing/#Messaging).
    pub fn publish(self: *Self, allocator: std.mem.Allocator, input: publish_.PublishInput, options: publish_.Options) !publish_.PublishOutput {
        return publish_.execute(self, allocator, input, options);
    }

    /// Updates the shadow for the specified thing.
    ///
    /// Requires permission to access the
    /// [UpdateThingShadow](https://docs.aws.amazon.com/service-authorization/latest/reference/list_awsiot.html#awsiot-actions-as-permissions) action.
    ///
    /// For more information, see
    /// [UpdateThingShadow](http://docs.aws.amazon.com/iot/latest/developerguide/API_UpdateThingShadow.html) in the
    /// IoT Developer Guide.
    pub fn updateThingShadow(self: *Self, allocator: std.mem.Allocator, input: update_thing_shadow.UpdateThingShadowInput, options: update_thing_shadow.Options) !update_thing_shadow.UpdateThingShadowOutput {
        return update_thing_shadow.execute(self, allocator, input, options);
    }

    pub fn listRetainedMessagesPaginator(self: *Self, params: list_retained_messages.ListRetainedMessagesInput) paginator.ListRetainedMessagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }
};
