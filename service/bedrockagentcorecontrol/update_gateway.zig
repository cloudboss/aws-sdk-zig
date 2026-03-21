const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const AuthorizerType = @import("authorizer_type.zig").AuthorizerType;
const ExceptionLevel = @import("exception_level.zig").ExceptionLevel;
const GatewayInterceptorConfiguration = @import("gateway_interceptor_configuration.zig").GatewayInterceptorConfiguration;
const GatewayPolicyEngineConfiguration = @import("gateway_policy_engine_configuration.zig").GatewayPolicyEngineConfiguration;
const GatewayProtocolConfiguration = @import("gateway_protocol_configuration.zig").GatewayProtocolConfiguration;
const GatewayProtocolType = @import("gateway_protocol_type.zig").GatewayProtocolType;
const GatewayStatus = @import("gateway_status.zig").GatewayStatus;
const WorkloadIdentityDetails = @import("workload_identity_details.zig").WorkloadIdentityDetails;

pub const UpdateGatewayInput = struct {
    /// The updated authorizer configuration for the gateway.
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// The updated authorizer type for the gateway.
    authorizer_type: AuthorizerType,

    /// The updated description for the gateway.
    description: ?[]const u8 = null,

    /// The level of detail in error messages returned when invoking the gateway.
    ///
    /// * If the value is `DEBUG`, granular exception messages are returned to help
    ///   a user debug the gateway.
    /// * If the value is omitted, a generic error message is returned to the end
    ///   user.
    exception_level: ?ExceptionLevel = null,

    /// The identifier of the gateway to update.
    gateway_identifier: []const u8,

    /// The updated interceptor configurations for the gateway.
    interceptor_configurations: ?[]const GatewayInterceptorConfiguration = null,

    /// The updated ARN of the KMS key used to encrypt the gateway.
    kms_key_arn: ?[]const u8 = null,

    /// The name of the gateway. This name must be the same as the one when the
    /// gateway was created.
    name: []const u8,

    /// The updated policy engine configuration for the gateway. A policy engine is
    /// a collection of policies that evaluates and authorizes agent tool calls.
    /// When associated with a gateway, the policy engine intercepts all agent
    /// requests and determines whether to allow or deny each action based on the
    /// defined policies.
    policy_engine_configuration: ?GatewayPolicyEngineConfiguration = null,

    protocol_configuration: ?GatewayProtocolConfiguration = null,

    /// The updated protocol type for the gateway.
    protocol_type: GatewayProtocolType,

    /// The updated IAM role ARN that provides permissions for the gateway.
    role_arn: []const u8,

    pub const json_field_names = .{
        .authorizer_configuration = "authorizerConfiguration",
        .authorizer_type = "authorizerType",
        .description = "description",
        .exception_level = "exceptionLevel",
        .gateway_identifier = "gatewayIdentifier",
        .interceptor_configurations = "interceptorConfigurations",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .policy_engine_configuration = "policyEngineConfiguration",
        .protocol_configuration = "protocolConfiguration",
        .protocol_type = "protocolType",
        .role_arn = "roleArn",
    };
};

pub const UpdateGatewayOutput = struct {
    /// The updated authorizer configuration for the gateway.
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// The updated authorizer type for the gateway.
    authorizer_type: AuthorizerType,

    /// The timestamp when the gateway was created.
    created_at: i64,

    /// The updated description of the gateway.
    description: ?[]const u8 = null,

    /// The level of detail in error messages returned when invoking the gateway.
    ///
    /// * If the value is `DEBUG`, granular exception messages are returned to help
    ///   a user debug the gateway.
    /// * If the value is omitted, a generic error message is returned to the end
    ///   user.
    exception_level: ?ExceptionLevel = null,

    /// The Amazon Resource Name (ARN) of the updated gateway.
    gateway_arn: []const u8,

    /// The unique identifier of the updated gateway.
    gateway_id: []const u8,

    /// An endpoint for invoking the updated gateway.
    gateway_url: ?[]const u8 = null,

    /// The updated interceptor configurations for the gateway.
    interceptor_configurations: ?[]const GatewayInterceptorConfiguration = null,

    /// The updated ARN of the KMS key used to encrypt the gateway.
    kms_key_arn: ?[]const u8 = null,

    /// The name of the gateway.
    name: []const u8,

    /// The updated policy engine configuration for the gateway.
    policy_engine_configuration: ?GatewayPolicyEngineConfiguration = null,

    protocol_configuration: ?GatewayProtocolConfiguration = null,

    /// The updated protocol type for the gateway.
    protocol_type: GatewayProtocolType,

    /// The updated IAM role ARN that provides permissions for the gateway.
    role_arn: ?[]const u8 = null,

    /// The current status of the updated gateway.
    status: GatewayStatus,

    /// The reasons for the current status of the updated gateway.
    status_reasons: ?[]const []const u8 = null,

    /// The timestamp when the gateway was last updated.
    updated_at: i64,

    /// The workload identity details for the updated gateway.
    workload_identity_details: ?WorkloadIdentityDetails = null,

    pub const json_field_names = .{
        .authorizer_configuration = "authorizerConfiguration",
        .authorizer_type = "authorizerType",
        .created_at = "createdAt",
        .description = "description",
        .exception_level = "exceptionLevel",
        .gateway_arn = "gatewayArn",
        .gateway_id = "gatewayId",
        .gateway_url = "gatewayUrl",
        .interceptor_configurations = "interceptorConfigurations",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .policy_engine_configuration = "policyEngineConfiguration",
        .protocol_configuration = "protocolConfiguration",
        .protocol_type = "protocolType",
        .role_arn = "roleArn",
        .status = "status",
        .status_reasons = "statusReasons",
        .updated_at = "updatedAt",
        .workload_identity_details = "workloadIdentityDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateGatewayInput, options: CallOptions) !UpdateGatewayOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/gateways/");
    try path_buf.appendSlice(allocator, input.gateway_identifier);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.authorizer_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authorizerConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"authorizerType\":");
    try aws.json.writeValue(@TypeOf(input.authorizer_type), input.authorizer_type, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.exception_level) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"exceptionLevel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.interceptor_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"interceptorConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.policy_engine_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"policyEngineConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.protocol_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"protocolConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"protocolType\":");
    try aws.json.writeValue(@TypeOf(input.protocol_type), input.protocol_type, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateGatewayOutput {
    var result: UpdateGatewayOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateGatewayOutput, body, allocator);
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
