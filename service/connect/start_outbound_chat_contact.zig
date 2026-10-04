const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Endpoint = @import("endpoint.zig").Endpoint;
const ChatMessage = @import("chat_message.zig").ChatMessage;
const TemplatedMessageConfig = @import("templated_message_config.zig").TemplatedMessageConfig;
const ParticipantDetails = @import("participant_details.zig").ParticipantDetails;
const SegmentAttributeValue = @import("segment_attribute_value.zig").SegmentAttributeValue;

pub const StartOutboundChatContactInput = struct {
    /// A custom key-value pair using an attribute map. The attributes are standard
    /// Connect Customer attributes, and
    /// can be accessed in flows just like any other contact attributes.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// The total duration of the newly started chat session. If not specified, the
    /// chat session duration defaults to 25
    /// hour. The minimum configurable time is 60 minutes. The maximum configurable
    /// time is 10,080 minutes (7 days).
    chat_duration_in_minutes: ?i32 = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If not provided,
    /// the Amazon Web Services SDK populates this field. For more information about
    /// idempotency, see [Making retries safe with
    /// idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/). The token is valid for 7 days after creation. If a contact is already started, the contact
    /// ID is returned.
    client_token: ?[]const u8 = null,

    /// The identifier of the flow for the call. To see the ContactFlowId in the
    /// Connect Customer console user
    /// interface, on the navigation menu go to **Routing, Contact Flows**. Choose
    /// the flow. On
    /// the flow page, under the name of the flow, choose **Show additional flow
    /// information**.
    /// The ContactFlowId is the last part of the ARN, shown here in bold:
    ///
    /// *
    ///   arn:aws:connect:us-west-2:xxxxxxxxxxxx:instance/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/contact-flow/**123ec456-a007-89c0-1234-xxxxxxxxxxxx**
    contact_flow_id: []const u8,

    destination_endpoint: Endpoint,

    initial_system_message: ?ChatMessage = null,

    initial_templated_system_message: ?TemplatedMessageConfig = null,

    /// The identifier of the Connect Customer instance. You can find the instance
    /// ID in the Amazon Resource Name
    /// (ARN) of the instance.
    instance_id: []const u8,

    participant_details: ?ParticipantDetails = null,

    /// The unique identifier for an Connect Customer contact. This identifier is
    /// related to the contact
    /// starting.
    related_contact_id: ?[]const u8 = null,

    /// A set of system defined key-value pairs stored on individual contact
    /// segments using an attribute map. The
    /// attributes are standard Connect Customer attributes. They can be accessed in
    /// flows.
    ///
    /// * Attribute keys can include only alphanumeric, `-`, and `_`.
    ///
    /// * This field can be used to show channel subtype, such as `connect:SMS` and
    /// `connect:WhatsApp`.
    segment_attributes: []const aws.map.MapEntry(SegmentAttributeValue),

    source_endpoint: Endpoint,

    /// The supported chat message content types. Supported types are:
    ///
    /// * `text/plain`
    ///
    /// * `text/markdown`
    ///
    /// * `application/json, application/vnd.amazonaws.connect.message.interactive`
    ///
    /// * `application/vnd.amazonaws.connect.message.interactive.response`
    ///
    /// Content types must always contain `text/plain`. You can then put any other
    /// supported type in the
    /// list. For example, all the following lists are valid because they contain
    /// `text/plain`:
    ///
    /// * `[text/plain, text/markdown, application/json]`
    ///
    /// * `[text/markdown, text/plain]`
    ///
    /// * `[text/plain, application/json,
    /// application/vnd.amazonaws.connect.message.interactive.response]`
    supported_messaging_content_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .chat_duration_in_minutes = "ChatDurationInMinutes",
        .client_token = "ClientToken",
        .contact_flow_id = "ContactFlowId",
        .destination_endpoint = "DestinationEndpoint",
        .initial_system_message = "InitialSystemMessage",
        .initial_templated_system_message = "InitialTemplatedSystemMessage",
        .instance_id = "InstanceId",
        .participant_details = "ParticipantDetails",
        .related_contact_id = "RelatedContactId",
        .segment_attributes = "SegmentAttributes",
        .source_endpoint = "SourceEndpoint",
        .supported_messaging_content_types = "SupportedMessagingContentTypes",
    };
};

pub const StartOutboundChatContactOutput = struct {
    /// The identifier of this contact within the Connect Customer instance.
    contact_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .contact_id = "ContactId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartOutboundChatContactInput, options: CallOptions) !StartOutboundChatContactOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartOutboundChatContactInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/contact/outbound-chat";

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
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ContactFlowId\":");
    try aws.json.writeValue(@TypeOf(input.contact_flow_id), input.contact_flow_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DestinationEndpoint\":");
    try aws.json.writeValue(@TypeOf(input.destination_endpoint), input.destination_endpoint, allocator, &body_buf);
    has_prev = true;
    if (input.initial_system_message) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InitialSystemMessage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.initial_templated_system_message) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InitialTemplatedSystemMessage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InstanceId\":");
    try aws.json.writeValue(@TypeOf(input.instance_id), input.instance_id, allocator, &body_buf);
    has_prev = true;
    if (input.participant_details) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ParticipantDetails\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.related_contact_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RelatedContactId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SegmentAttributes\":");
    try aws.json.writeValue(@TypeOf(input.segment_attributes), input.segment_attributes, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SourceEndpoint\":");
    try aws.json.writeValue(@TypeOf(input.source_endpoint), input.source_endpoint, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartOutboundChatContactOutput {
    const result: StartOutboundChatContactOutput = try aws.json.parseJsonObject(
        StartOutboundChatContactOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
