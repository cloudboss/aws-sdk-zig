const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChatStreamingConfiguration = @import("chat_streaming_configuration.zig").ChatStreamingConfiguration;
const ConnectionType = @import("connection_type.zig").ConnectionType;
const DisconnectOnCustomerExitParticipantType = @import("disconnect_on_customer_exit_participant_type.zig").DisconnectOnCustomerExitParticipantType;
const ChatMessage = @import("chat_message.zig").ChatMessage;
const ParticipantConfiguration = @import("participant_configuration.zig").ParticipantConfiguration;
const ParticipantDetails = @import("participant_details.zig").ParticipantDetails;
const PersistentChat = @import("persistent_chat.zig").PersistentChat;
const SegmentAttributeValue = @import("segment_attribute_value.zig").SegmentAttributeValue;
const ConnectionCredentials = @import("connection_credentials.zig").ConnectionCredentials;
const Websocket = @import("websocket.zig").Websocket;

pub const StartChatContactInput = struct {
    /// A custom key-value pair using an attribute map. The attributes are standard
    /// Connect Customer attributes. They
    /// can be accessed in flows just like any other contact attributes.
    ///
    /// There can be up to 32,768 UTF-8 bytes across all key-value pairs per
    /// contact. Attribute keys can include only
    /// alphanumeric, dash, and underscore characters.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The total duration of the newly started chat session. If not specified, the
    /// chat session duration defaults to 25
    /// hour. The minimum configurable time is 60 minutes. The maximum configurable
    /// time is 10,080 minutes (7 days).
    chat_duration_in_minutes: ?i32 = null,

    /// The streaming configuration, such as the Amazon SNS streaming endpoint. Use
    /// it to initiate real-time
    /// message streaming when the chat is created. This parameter is optional.
    ///
    /// Setting this parameter returns a `StreamingId` in the response, and you do
    /// not need to call
    /// [StartContactStreaming](https://docs.aws.amazon.com/connect/latest/APIReference/API_StartContactStreaming.html).
    ///
    /// This parameter starts message streaming only. The response does not include
    /// connection information, and setting
    /// this parameter does not remove the need to call
    /// [CreateParticipantConnection](https://docs.aws.amazon.com/connect-participant/latest/APIReference/API_CreateParticipantConnection.html).
    chat_streaming_configuration: ?ChatStreamingConfiguration = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// The types of connection information to return in the response. This
    /// parameter is optional.
    ///
    /// To receive connection information, specify one or both of the following
    /// values:
    ///
    /// * `CONNECTION_CREDENTIALS`: Returns a connection token.
    ///
    /// * `WEBSOCKET`: Returns a websocket URL.
    ///
    /// `WEBSOCKET` and `CONNECTION_CREDENTIALS` are the values this operation acts
    /// on. No other
    /// value returns connection information.
    ///
    /// Request `WEBSOCKET` to get a URL the participant connects to directly. You
    /// do not need to call
    /// [CreateParticipantConnection](https://docs.aws.amazon.com/connect-participant/latest/APIReference/API_CreateParticipantConnection.html) for it. Request `CONNECTION_CREDENTIALS` on its own and the response
    /// returns a connection token but no websocket URL.
    ///
    /// If you omit this parameter, the response has no connection information.
    ///
    /// When you start a new chat contact and the information you request cannot be
    /// returned, StartChatContact returns
    /// an error rather than a response that omits it. When you retry a request with
    /// the same `ClientToken`, the
    /// response repeats the original contact and can omit a websocket URL if the
    /// chat has already ended.
    connection_types: ?[]const ConnectionType = null,

    /// The identifier of the flow for initiating the chat.
    /// To
    /// see the ContactFlowId in the Connect Customer admin website, on the
    /// navigation menu go to **Routing**, **Flows**. Choose the flow. On the flow
    /// page, under the name of the flow, choose **Show additional flow
    /// information**. The ContactFlowId is the last part of the ARN, shown here
    /// in bold:
    ///
    /// arn:aws:connect:us-west-2:xxxxxxxxxxxx:instance/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/contact-flow/**846ec553-a005-41c0-8341-xxxxxxxxxxxx**
    contact_flow_id: []const u8,

    /// The customer's identification number. For example, the `CustomerId` may be a
    /// customer number from
    /// your CRM.
    customer_id: ?[]const u8 = null,

    /// A list of participant types to automatically disconnect when the end
    /// customer ends the chat session, allowing them to continue through disconnect
    /// flows such as surveys or feedback forms.
    disconnect_on_customer_exit: ?[]const DisconnectOnCustomerExitParticipantType = null,

    /// The initial message to be sent to the newly created chat.
    initial_message: ?ChatMessage = null,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The configuration of the participant.
    participant_configuration: ?ParticipantConfiguration = null,

    /// Information identifying the participant.
    participant_details: ParticipantDetails,

    /// Enable persistent chats. For more information about enabling persistent
    /// chat, and for example use cases and how
    /// to configure for them, see [Enable
    /// persistent
    /// chat](https://docs.aws.amazon.com/connect/latest/adminguide/chat-persistence.html).
    persistent_chat: ?PersistentChat = null,

    /// The unique identifier for an Connect Customer contact. This identifier is
    /// related to the chat starting.
    ///
    /// You cannot provide data for both RelatedContactId and PersistentChat.
    related_contact_id: ?[]const u8 = null,

    /// A set of system defined key-value pairs stored on individual contact
    /// segments using an attribute map. The
    /// attributes are standard Connect Customer attributes. They can be accessed in
    /// flows.
    ///
    /// Attribute keys can include only alphanumeric, -, and _.
    ///
    /// This field can be used to show channel subtype, such as `connect:Guide`.
    ///
    /// The types `application/vnd.amazonaws.connect.message.interactive` and
    /// `application/vnd.amazonaws.connect.message.interactive.response` must be
    /// present in the
    /// SupportedMessagingContentTypes field of this API in order to set
    /// `SegmentAttributes` as {`
    /// "connect:Subtype": {"valueString" : "connect:Guide" }}`.
    segment_attributes: ?[]const aws.map.MapEntry(SegmentAttributeValue) = null,

    /// The supported chat message content types. Supported types are `text/plain`,
    /// `text/markdown`, `application/json`,
    /// `application/vnd.amazonaws.connect.message.interactive`, and
    /// `application/vnd.amazonaws.connect.message.interactive.response`.
    ///
    /// Content types must always contain `text/plain`. You can then put any other
    /// supported type in the
    /// list. For example, all the following lists are valid because they contain
    /// `text/plain`: `[text/plain,
    /// text/markdown, application/json]`, `[text/markdown, text/plain]`,
    /// `[text/plain,
    /// application/json,
    /// application/vnd.amazonaws.connect.message.interactive.response]`.
    ///
    /// The type `application/vnd.amazonaws.connect.message.interactive` is required
    /// to use the [Show
    /// view](https://docs.aws.amazon.com/connect/latest/adminguide/show-view-block.html) flow block.
    supported_messaging_content_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .chat_duration_in_minutes = "ChatDurationInMinutes",
        .chat_streaming_configuration = "ChatStreamingConfiguration",
        .client_token = "ClientToken",
        .connection_types = "ConnectionTypes",
        .contact_flow_id = "ContactFlowId",
        .customer_id = "CustomerId",
        .disconnect_on_customer_exit = "DisconnectOnCustomerExit",
        .initial_message = "InitialMessage",
        .instance_id = "InstanceId",
        .participant_configuration = "ParticipantConfiguration",
        .participant_details = "ParticipantDetails",
        .persistent_chat = "PersistentChat",
        .related_contact_id = "RelatedContactId",
        .segment_attributes = "SegmentAttributes",
        .supported_messaging_content_types = "SupportedMessagingContentTypes",
    };
};

pub const StartChatContactOutput = struct {
    /// The connection credentials for the chat participant. Returned only when the
    /// request includes
    /// `CONNECTION_CREDENTIALS` in `ConnectionTypes`.
    connection_credentials: ?ConnectionCredentials = null,

    /// The identifier of this contact within the Connect Customer instance.
    contact_id: ?[]const u8 = null,

    /// The contactId from which a persistent chat session is started. This field is
    /// populated only for persistent
    /// chats.
    continued_from_contact_id: ?[]const u8 = null,

    /// The identifier for a chat participant. The participantId for a chat
    /// participant is the same throughout the chat
    /// lifecycle.
    participant_id: ?[]const u8 = null,

    /// The token used by the chat participant to call
    /// [CreateParticipantConnection](https://docs.aws.amazon.com/connect-participant/latest/APIReference/API_CreateParticipantConnection.html). The participant token is valid for the lifetime of a chat participant.
    participant_token: ?[]const u8 = null,

    /// The identifier of the streaming configuration enabled with the chat.
    /// Returned only when the request sets
    /// `ChatStreamingConfiguration`. Use this value to call
    /// [StopContactStreaming](https://docs.aws.amazon.com/connect/latest/APIReference/API_StopContactStreaming.html).
    streaming_id: ?[]const u8 = null,

    /// The websocket for the chat participant. Returned only when the request
    /// includes `WEBSOCKET` in
    /// `ConnectionTypes`.
    websocket: ?Websocket = null,

    pub const json_field_names = .{
        .connection_credentials = "ConnectionCredentials",
        .contact_id = "ContactId",
        .continued_from_contact_id = "ContinuedFromContactId",
        .participant_id = "ParticipantId",
        .participant_token = "ParticipantToken",
        .streaming_id = "StreamingId",
        .websocket = "Websocket",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartChatContactInput, options: CallOptions) !StartChatContactOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: StartChatContactInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/contact/chat";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Attributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.chat_duration_in_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ChatDurationInMinutes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.chat_streaming_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ChatStreamingConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.connection_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConnectionTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ContactFlowId\":");
    try aws.json.writeValue(@TypeOf(input.contact_flow_id), input.contact_flow_id, allocator, &body_buf);
    has_prev = true;
    if (input.customer_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CustomerId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.disconnect_on_customer_exit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DisconnectOnCustomerExit\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.initial_message) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InitialMessage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InstanceId\":");
    try aws.json.writeValue(@TypeOf(input.instance_id), input.instance_id, allocator, &body_buf);
    has_prev = true;
    if (input.participant_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ParticipantConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ParticipantDetails\":");
    try aws.json.writeValue(@TypeOf(input.participant_details), input.participant_details, allocator, &body_buf);
    has_prev = true;
    if (input.persistent_chat) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PersistentChat\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.related_contact_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RelatedContactId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.segment_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SegmentAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.supported_messaging_content_types) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SupportedMessagingContentTypes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartChatContactOutput {
    const result: StartChatContactOutput = try aws.json.parseJsonObject(
        StartChatContactOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
