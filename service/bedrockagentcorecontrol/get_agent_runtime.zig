const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AgentRuntimeArtifact = @import("agent_runtime_artifact.zig").AgentRuntimeArtifact;
const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const LifecycleConfiguration = @import("lifecycle_configuration.zig").LifecycleConfiguration;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const ProtocolConfiguration = @import("protocol_configuration.zig").ProtocolConfiguration;
const RequestHeaderConfiguration = @import("request_header_configuration.zig").RequestHeaderConfiguration;
const AgentRuntimeStatus = @import("agent_runtime_status.zig").AgentRuntimeStatus;
const WorkloadIdentityDetails = @import("workload_identity_details.zig").WorkloadIdentityDetails;

pub const GetAgentRuntimeInput = struct {
    /// The unique identifier of the AgentCore Runtime to retrieve.
    agent_runtime_id: []const u8,

    /// The version of the AgentCore Runtime to retrieve.
    agent_runtime_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .agent_runtime_id = "agentRuntimeId",
        .agent_runtime_version = "agentRuntimeVersion",
    };
};

pub const GetAgentRuntimeOutput = struct {
    /// The Amazon Resource Name (ARN) of the AgentCore Runtime.
    agent_runtime_arn: []const u8,

    /// The artifact of the AgentCore Runtime.
    agent_runtime_artifact: ?AgentRuntimeArtifact = null,

    /// The unique identifier of the AgentCore Runtime.
    agent_runtime_id: []const u8,

    /// The name of the AgentCore Runtime.
    agent_runtime_name: []const u8,

    /// The version of the AgentCore Runtime.
    agent_runtime_version: []const u8,

    /// The authorizer configuration for the AgentCore Runtime.
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// The timestamp when the AgentCore Runtime was created.
    created_at: i64,

    /// The description of the AgentCore Runtime.
    description: ?[]const u8 = null,

    /// Environment variables set in the AgentCore Runtime environment.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// The reason for failure if the AgentCore Runtime is in a failed state.
    failure_reason: ?[]const u8 = null,

    /// The timestamp when the AgentCore Runtime was last updated.
    last_updated_at: i64,

    /// The life cycle configuration for the AgentCore Runtime.
    lifecycle_configuration: ?LifecycleConfiguration = null,

    /// The network configuration for the AgentCore Runtime.
    network_configuration: ?NetworkConfiguration = null,

    protocol_configuration: ?ProtocolConfiguration = null,

    /// Configuration for HTTP request headers that will be passed through to the
    /// runtime.
    request_header_configuration: ?RequestHeaderConfiguration = null,

    /// The IAM role ARN that provides permissions for the AgentCore Runtime.
    role_arn: []const u8,

    /// The current status of the AgentCore Runtime.
    status: AgentRuntimeStatus,

    /// The workload identity details for the AgentCore Runtime.
    workload_identity_details: ?WorkloadIdentityDetails = null,

    pub const json_field_names = .{
        .agent_runtime_arn = "agentRuntimeArn",
        .agent_runtime_artifact = "agentRuntimeArtifact",
        .agent_runtime_id = "agentRuntimeId",
        .agent_runtime_name = "agentRuntimeName",
        .agent_runtime_version = "agentRuntimeVersion",
        .authorizer_configuration = "authorizerConfiguration",
        .created_at = "createdAt",
        .description = "description",
        .environment_variables = "environmentVariables",
        .failure_reason = "failureReason",
        .last_updated_at = "lastUpdatedAt",
        .lifecycle_configuration = "lifecycleConfiguration",
        .network_configuration = "networkConfiguration",
        .protocol_configuration = "protocolConfiguration",
        .request_header_configuration = "requestHeaderConfiguration",
        .role_arn = "roleArn",
        .status = "status",
        .workload_identity_details = "workloadIdentityDetails",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAgentRuntimeInput, options: Options) !GetAgentRuntimeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrockagentcorecontrol");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAgentRuntimeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrockagentcorecontrol", "Bedrock AgentCore Control", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/runtimes/");
    try path_buf.appendSlice(allocator, input.agent_runtime_id);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.agent_runtime_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "version=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAgentRuntimeOutput {
    var result: GetAgentRuntimeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAgentRuntimeOutput, body, allocator);
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
