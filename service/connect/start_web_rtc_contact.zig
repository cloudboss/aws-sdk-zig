const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AllowedCapabilities = @import("allowed_capabilities.zig").AllowedCapabilities;
const ParticipantDetails = @import("participant_details.zig").ParticipantDetails;
const Reference = @import("reference.zig").Reference;
const SegmentAttributeValue = @import("segment_attribute_value.zig").SegmentAttributeValue;
const ConnectionData = @import("connection_data.zig").ConnectionData;

pub const StartWebRTCContactInput = struct {
    /// Information about the video sharing capabilities of the participants
    /// (customer, agent).
    allowed_capabilities: ?AllowedCapabilities = null,

    /// A custom key-value pair using an attribute map. The attributes are standard
    /// Connect Customer attributes, and
    /// can be accessed in flows just like any other contact attributes.
    ///
    /// There can be up to 32,768 UTF-8 bytes across all key-value pairs per
    /// contact. Attribute keys can include only
    /// alphanumeric, -, and _ characters.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the
    /// request. If not provided, the Amazon Web Services
    /// SDK populates this field. For more information about idempotency, see
    /// [Making retries safe with idempotent
    /// APIs](https://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    ///
    /// The token is valid for 7 days after creation. If a contact is already
    /// started, the contact ID is
    /// returned.
    client_token: ?[]const u8 = null,

    /// The identifier of the flow for the call. To see the ContactFlowId in the
    /// Connect Customer admin website, on the navigation menu go to
    /// **Routing**, **Flows**. Choose the flow. On the flow page,
    /// under the name of the flow, choose **Show additional flow information**. The
    /// ContactFlowId is the last part of the ARN, shown here in bold:
    ///
    /// arn:aws:connect:us-west-2:xxxxxxxxxxxx:instance/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/contact-flow/**846ec553-a005-41c0-8341-xxxxxxxxxxxx**
    contact_flow_id: []const u8,

    /// A description of the task that is shown to an agent in the Contact Control
    /// Panel (CCP).
    description: ?[]const u8 = null,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    participant_details: ParticipantDetails,

    /// A formatted URL that is shown to an agent in the Contact Control Panel
    /// (CCP). Tasks can have the following
    /// reference types at the time of creation: `URL` | `NUMBER` | `STRING` |
    /// `DATE` | `EMAIL`. `ATTACHMENT` is not a supported reference type during task
    /// creation.
    references: ?[]const aws.map.MapEntry(Reference) = null,

    /// The unique identifier for an Connect Customer contact. This identifier is
    /// related to the contact
    /// starting.
    related_contact_id: ?[]const u8 = null,

    /// A map of system-defined attributes for the WebRTC contact segment. Use the
    /// `connect:Subtype` attribute to specify the channel subtype, such as
    /// `connect:WebRTC`.
    segment_attributes: ?[]const aws.map.MapEntry(SegmentAttributeValue) = null,

    pub const json_field_names = .{
        .allowed_capabilities = "AllowedCapabilities",
        .attributes = "Attributes",
        .client_token = "ClientToken",
        .contact_flow_id = "ContactFlowId",
        .description = "Description",
        .instance_id = "InstanceId",
        .participant_details = "ParticipantDetails",
        .references = "References",
        .related_contact_id = "RelatedContactId",
        .segment_attributes = "SegmentAttributes",
    };
};

pub const StartWebRTCContactOutput = struct {
    /// Information required for the client application (mobile application or
    /// website) to connect to the call.
    connection_data: ?ConnectionData = null,

    /// The identifier of the contact in this instance of Connect Customer.
    contact_id: ?[]const u8 = null,

    /// The identifier for a contact participant. The `ParticipantId` for a contact
    /// participant is the same
    /// throughout the contact lifecycle.
    participant_id: ?[]const u8 = null,

    /// The token used by the contact participant to call the
    /// [CreateParticipantConnection](https://docs.aws.amazon.com/connect-participant/latest/APIReference/API_CreateParticipantConnection.html) API. The participant token is valid for the lifetime of a contact
    /// participant.
    participant_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .connection_data = "ConnectionData",
        .contact_id = "ContactId",
        .participant_id = "ParticipantId",
        .participant_token = "ParticipantToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartWebRTCContactInput, options: CallOptions) !StartWebRTCContactOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartWebRTCContactInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/contact/webrtc";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.allowed_capabilities) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AllowedCapabilities\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Attributes\":");
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
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InstanceId\":");
    try aws.json.writeValue(@TypeOf(input.instance_id), input.instance_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ParticipantDetails\":");
    try aws.json.writeValue(@TypeOf(input.participant_details), input.participant_details, allocator, &body_buf);
    has_prev = true;
    if (input.references) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"References\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartWebRTCContactOutput {
    const result: StartWebRTCContactOutput = try aws.json.parseJsonObject(
        StartWebRTCContactOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
