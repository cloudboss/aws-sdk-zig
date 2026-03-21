const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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

    /// The connectors for use with Amazon Connect.
    ///
    /// The following options are available:
    ///
    /// * `CONNECT_CALL_TRANSFER_CONNECTOR` - Enables enterprises to integrate
    /// Amazon Connect with other voice systems to directly transfer voice calls and
    /// metadata without using the public telephone network. They can use Amazon
    /// Connect
    /// telephony and Interactive Voice Response (IVR) with their existing voice
    /// systems to
    /// modernize the IVR experience of their existing contact center and their
    /// enterprise
    /// and branch voice systems. Additionally, enterprises migrating their contact
    /// center to
    /// Amazon Connect can start with Connect telephony and IVR for immediate
    /// modernization ahead of agent migration.
    ///
    /// * `CONNECT_ANALYTICS_CONNECTOR` - Enables enterprises to integrate
    /// Amazon Connect with other voice systems for real-time and post-call
    /// analytics.
    /// They can use Amazon Connect Contact Lens with their existing voice systems
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
    /// migrating their contact center to Amazon Connect can start with Contact Lens
    /// analytics and performance insights ahead of agent migration.
    integration_type: ?VoiceConnectorIntegrationType = null,

    /// The name of the Voice Connector.
    name: []const u8,

    /// The type of network for the Voice Connector. Either IPv4 only or dual-stack
    /// (IPv4 and IPv6).
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

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "chime");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVoiceConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("voice-chime", "Chime SDK Voice", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/voice-connectors";

    var body_buf: std.ArrayList(u8) = .{};
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVoiceConnectorOutput {
    var result: CreateVoiceConnectorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateVoiceConnectorOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GoneException")) {
        return .{ .arena = arena, .kind = .{ .gone_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .resource_limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceFailureException")) {
        return .{ .arena = arena, .kind = .{ .service_failure_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottledClientException")) {
        return .{ .arena = arena, .kind = .{ .throttled_client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedClientException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnprocessableEntityException")) {
        return .{ .arena = arena, .kind = .{ .unprocessable_entity_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
