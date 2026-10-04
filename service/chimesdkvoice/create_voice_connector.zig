const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VoiceConnectorAwsRegion = @import("voice_connector_aws_region.zig").VoiceConnectorAwsRegion;
const VoiceConnectorIntegrationType = @import("voice_connector_integration_type.zig").VoiceConnectorIntegrationType;
const NetworkType = @import("network_type.zig").NetworkType;
const Tag = @import("tag.zig").Tag;
const VoiceConnector = @import("voice_connector.zig").VoiceConnector;

pub const CreateVoiceConnectorInput = struct {
    /// The AWS Region in which the Amazon Chime SDK Voice Connector is created.
    /// Default value:
    /// `us-east-1` .
    aws_region: ?VoiceConnectorAwsRegion = null,

    /// The connectors for use with Connect Customer.
    ///
    /// The following options are available:
    ///
    /// * `CONNECT_CALL_TRANSFER_CONNECTOR` - Enables enterprises to integrate
    /// Connect Customer with other voice systems to directly transfer voice calls
    /// and
    /// metadata without using the public telephone network. They can use Connect
    /// Customer
    /// telephony and Interactive Voice Response (IVR) with their existing voice
    /// systems to
    /// modernize the IVR experience of their existing contact center and their
    /// enterprise
    /// and branch voice systems. Additionally, enterprises migrating their contact
    /// center to
    /// Connect Customer can start with Connect telephony and IVR for immediate
    /// modernization ahead of agent migration.
    ///
    /// This integration is a gated feature. Please reach out to your account team
    /// to
    /// discuss this feature with a Connect Specialist.
    ///
    /// * `CONNECT_ANALYTICS_CONNECTOR` - Enables enterprises to integrate
    /// Connect Customer with other voice systems for real-time and post-call
    /// analytics.
    /// They can use Connect Customer Contact Lens with their existing voice systems
    /// to
    /// provides call recordings, conversational analytics (including contact
    /// transcript,
    /// sensitive data redaction, content categorization, theme detection, sentiment
    /// analysis, real-time alerts, and post-contact summary), and agent performance
    /// evaluations (including evaluation forms, automated evaluation, supervisor
    /// review)
    /// with a rich user experience to display, search and filter customer
    /// interactions, and
    /// programmatic access to data streams and the data lake. Additionally,
    /// enterprises
    /// migrating their contact center to Connect Customer can start with Contact
    /// Lens
    /// analytics and performance insights ahead of agent migration.
    integration_type: ?VoiceConnectorIntegrationType = null,

    /// The name of the Voice Connector.
    name: []const u8,

    /// The type of network for the Voice Connector.
    network_type: ?NetworkType = null,

    /// Enables or disables encryption for the Voice Connector.
    require_encryption: bool,

    /// The tags assigned to the Voice Connector.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .aws_region = "AwsRegion",
        .integration_type = "IntegrationType",
        .name = "Name",
        .network_type = "NetworkType",
        .require_encryption = "RequireEncryption",
        .tags = "Tags",
    };
};

pub const CreateVoiceConnectorOutput = struct {
    /// The details of the Voice Connector.
    voice_connector: ?VoiceConnector = null,

    pub const json_field_names = .{
        .voice_connector = "VoiceConnector",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVoiceConnectorInput, options: CallOptions) !CreateVoiceConnectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVoiceConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voice-chime", "Chime SDK Voice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/voice-connectors";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.aws_region) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AwsRegion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.integration_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IntegrationType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.network_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NetworkType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RequireEncryption\":");
    try aws.json.writeValue(@TypeOf(input.require_encryption), input.require_encryption, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVoiceConnectorOutput {
    const result: CreateVoiceConnectorOutput = try aws.json.parseJsonObject(
        CreateVoiceConnectorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
