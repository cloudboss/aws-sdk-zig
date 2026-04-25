const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AgentRuntimeArtifact = @import("agent_runtime_artifact.zig").AgentRuntimeArtifact;
const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const FilesystemConfiguration = @import("filesystem_configuration.zig").FilesystemConfiguration;
const LifecycleConfiguration = @import("lifecycle_configuration.zig").LifecycleConfiguration;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const ProtocolConfiguration = @import("protocol_configuration.zig").ProtocolConfiguration;
const RequestHeaderConfiguration = @import("request_header_configuration.zig").RequestHeaderConfiguration;
const AgentRuntimeStatus = @import("agent_runtime_status.zig").AgentRuntimeStatus;
const WorkloadIdentityDetails = @import("workload_identity_details.zig").WorkloadIdentityDetails;

pub const CreateAgentRuntimeInput = struct {
    /// The artifact of the AgentCore Runtime.
    agent_runtime_artifact: AgentRuntimeArtifact,

    /// The name of the AgentCore Runtime.
    agent_runtime_name: []const u8,

    /// The authorizer configuration for the AgentCore Runtime.
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The description of the AgentCore Runtime.
    description: ?[]const u8 = null,

    /// Environment variables to set in the AgentCore Runtime environment.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// The filesystem configurations to mount into the AgentCore Runtime. Use
    /// filesystem configurations to provide persistent storage to your AgentCore
    /// Runtime sessions.
    filesystem_configurations: ?[]const FilesystemConfiguration = null,

    /// The life cycle configuration for the AgentCore Runtime.
    lifecycle_configuration: ?LifecycleConfiguration = null,

    /// The network configuration for the AgentCore Runtime.
    network_configuration: NetworkConfiguration,

    protocol_configuration: ?ProtocolConfiguration = null,

    /// Configuration for HTTP request headers that will be passed through to the
    /// runtime.
    request_header_configuration: ?RequestHeaderConfiguration = null,

    /// The IAM role ARN that provides permissions for the AgentCore Runtime.
    role_arn: []const u8,

    /// A map of tag keys and values to assign to the agent runtime. Tags enable you
    /// to categorize your resources in different ways, for example, by purpose,
    /// owner, or environment.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .agent_runtime_artifact = "agentRuntimeArtifact",
        .agent_runtime_name = "agentRuntimeName",
        .authorizer_configuration = "authorizerConfiguration",
        .client_token = "clientToken",
        .description = "description",
        .environment_variables = "environmentVariables",
        .filesystem_configurations = "filesystemConfigurations",
        .lifecycle_configuration = "lifecycleConfiguration",
        .network_configuration = "networkConfiguration",
        .protocol_configuration = "protocolConfiguration",
        .request_header_configuration = "requestHeaderConfiguration",
        .role_arn = "roleArn",
        .tags = "tags",
    };
};

pub const CreateAgentRuntimeOutput = struct {
    /// The Amazon Resource Name (ARN) of the AgentCore Runtime.
    agent_runtime_arn: []const u8,

    /// The unique identifier of the AgentCore Runtime.
    agent_runtime_id: []const u8,

    /// The version of the AgentCore Runtime.
    agent_runtime_version: []const u8,

    /// The timestamp when the AgentCore Runtime was created.
    created_at: i64,

    /// The current status of the AgentCore Runtime.
    status: AgentRuntimeStatus,

    /// The workload identity details for the AgentCore Runtime.
    workload_identity_details: ?WorkloadIdentityDetails = null,

    pub const json_field_names = .{
        .agent_runtime_arn = "agentRuntimeArn",
        .agent_runtime_id = "agentRuntimeId",
        .agent_runtime_version = "agentRuntimeVersion",
        .created_at = "createdAt",
        .status = "status",
        .workload_identity_details = "workloadIdentityDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAgentRuntimeInput, options: CallOptions) !CreateAgentRuntimeOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAgentRuntimeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/runtimes/";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agentRuntimeArtifact\":");
    try aws.json.writeValue(@TypeOf(input.agent_runtime_artifact), input.agent_runtime_artifact, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agentRuntimeName\":");
    try aws.json.writeValue(@TypeOf(input.agent_runtime_name), input.agent_runtime_name, allocator, &body_buf);
    has_prev = true;
    if (input.authorizer_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authorizerConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.environment_variables) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"environmentVariables\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filesystem_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filesystemConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.lifecycle_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"lifecycleConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"networkConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.network_configuration), input.network_configuration, allocator, &body_buf);
    has_prev = true;
    if (input.protocol_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"protocolConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.request_header_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"requestHeaderConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAgentRuntimeOutput {
    var result: CreateAgentRuntimeOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAgentRuntimeOutput, body, allocator);
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
