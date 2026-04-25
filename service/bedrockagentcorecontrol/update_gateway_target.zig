const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const CredentialProviderConfiguration = @import("credential_provider_configuration.zig").CredentialProviderConfiguration;
const MetadataConfiguration = @import("metadata_configuration.zig").MetadataConfiguration;
const PrivateEndpoint = @import("private_endpoint.zig").PrivateEndpoint;
const TargetConfiguration = @import("target_configuration.zig").TargetConfiguration;
const AuthorizationData = @import("authorization_data.zig").AuthorizationData;
const ManagedResourceDetails = @import("managed_resource_details.zig").ManagedResourceDetails;
const TargetStatus = @import("target_status.zig").TargetStatus;

pub const UpdateGatewayTargetInput = struct {
    /// The updated credential provider configurations for the gateway target.
    credential_provider_configurations: ?[]const CredentialProviderConfiguration = null,

    /// The updated description for the gateway target.
    description: ?[]const u8 = null,

    /// The unique identifier of the gateway associated with the target.
    gateway_identifier: []const u8,

    /// Configuration for HTTP header and query parameter propagation to the gateway
    /// target.
    metadata_configuration: ?MetadataConfiguration = null,

    /// The updated name for the gateway target.
    name: []const u8,

    /// The private endpoint configuration for the gateway target. Use this to
    /// connect the gateway to private resources in your VPC.
    private_endpoint: ?PrivateEndpoint = null,

    target_configuration: TargetConfiguration,

    /// The unique identifier of the gateway target to update.
    target_id: []const u8,

    pub const json_field_names = .{
        .credential_provider_configurations = "credentialProviderConfigurations",
        .description = "description",
        .gateway_identifier = "gatewayIdentifier",
        .metadata_configuration = "metadataConfiguration",
        .name = "name",
        .private_endpoint = "privateEndpoint",
        .target_configuration = "targetConfiguration",
        .target_id = "targetId",
    };
};

pub const UpdateGatewayTargetOutput = struct {
    /// OAuth2 authorization data for the updated gateway target. This data is
    /// returned when a target is configured with a credential provider with
    /// authorization code grant type and requires user federation.
    authorization_data: ?AuthorizationData = null,

    /// The timestamp when the gateway target was created.
    created_at: i64,

    /// The updated credential provider configurations for the gateway target.
    credential_provider_configurations: ?[]const CredentialProviderConfiguration = null,

    /// The updated description of the gateway target.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the gateway.
    gateway_arn: []const u8,

    /// The date and time at which the targets were last synchronized.
    last_synchronized_at: ?i64 = null,

    /// The metadata configuration that was applied to the gateway target.
    metadata_configuration: ?MetadataConfiguration = null,

    /// The updated name of the gateway target.
    name: []const u8,

    /// The private endpoint configuration for the gateway target.
    private_endpoint: ?PrivateEndpoint = null,

    /// The managed resources created by the gateway for private endpoint
    /// connectivity.
    private_endpoint_managed_resources: ?[]const ManagedResourceDetails = null,

    /// The current status of the updated gateway target.
    status: TargetStatus,

    /// The reasons for the current status of the updated gateway target.
    status_reasons: ?[]const []const u8 = null,

    target_configuration: ?TargetConfiguration = null,

    /// The unique identifier of the updated gateway target.
    target_id: []const u8,

    /// The timestamp when the gateway target was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .authorization_data = "authorizationData",
        .created_at = "createdAt",
        .credential_provider_configurations = "credentialProviderConfigurations",
        .description = "description",
        .gateway_arn = "gatewayArn",
        .last_synchronized_at = "lastSynchronizedAt",
        .metadata_configuration = "metadataConfiguration",
        .name = "name",
        .private_endpoint = "privateEndpoint",
        .private_endpoint_managed_resources = "privateEndpointManagedResources",
        .status = "status",
        .status_reasons = "statusReasons",
        .target_configuration = "targetConfiguration",
        .target_id = "targetId",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGatewayTargetInput, options: CallOptions) !UpdateGatewayTargetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrock-agentcore");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGatewayTargetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/gateways/");
    try path_buf.appendSlice(allocator, input.gateway_identifier);
    try path_buf.appendSlice(allocator, "/targets/");
    try path_buf.appendSlice(allocator, input.target_id);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.credential_provider_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"credentialProviderConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metadata_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metadataConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.private_endpoint) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"privateEndpoint\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.target_configuration), input.target_configuration, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGatewayTargetOutput {
    var result: UpdateGatewayTargetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateGatewayTargetOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
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
    if (std.mem.eql(u8, error_code, "DecryptionFailure")) {
        return .{ .arena = arena, .kind = .{ .decryption_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "EncryptionFailure")) {
        return .{ .arena = arena, .kind = .{ .encryption_failure = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceException")) {
        return .{ .arena = arena, .kind = .{ .service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottledException")) {
        return .{ .arena = arena, .kind = .{ .throttled_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
