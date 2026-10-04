const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgentRuntimeArtifact = @import("agent_runtime_artifact.zig").AgentRuntimeArtifact;
const AuthorizerConfiguration = @import("authorizer_configuration.zig").AuthorizerConfiguration;
const CapacityProviderConfiguration = @import("capacity_provider_configuration.zig").CapacityProviderConfiguration;
const FilesystemConfiguration = @import("filesystem_configuration.zig").FilesystemConfiguration;
const LifecycleConfiguration = @import("lifecycle_configuration.zig").LifecycleConfiguration;
const RuntimeMetadataConfiguration = @import("runtime_metadata_configuration.zig").RuntimeMetadataConfiguration;
const NetworkConfiguration = @import("network_configuration.zig").NetworkConfiguration;
const ProtocolConfiguration = @import("protocol_configuration.zig").ProtocolConfiguration;
const RequestHeaderConfiguration = @import("request_header_configuration.zig").RequestHeaderConfiguration;
const AgentRuntimeStatus = @import("agent_runtime_status.zig").AgentRuntimeStatus;
const WorkloadIdentityDetails = @import("workload_identity_details.zig").WorkloadIdentityDetails;

pub const UpdateAgentRuntimeInput = struct {
    /// The updated artifact of the AgentCore Runtime.
    agent_runtime_artifact: AgentRuntimeArtifact,

    /// The unique identifier of the AgentCore Runtime to update.
    agent_runtime_id: []const u8,

    /// The updated authorizer configuration for the AgentCore Runtime.
    authorizer_configuration: ?AuthorizerConfiguration = null,

    /// The updated capacity provider configuration for the AgentCore Runtime.
    capacity_provider_configuration: ?CapacityProviderConfiguration = null,

    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The updated description of the AgentCore Runtime.
    description: ?[]const u8 = null,

    /// Updated environment variables to set in the AgentCore Runtime environment.
    environment_variables: ?[]const aws.map.StringMapEntry = null,

    /// The updated filesystem configurations to mount into the AgentCore Runtime.
    filesystem_configurations: ?[]const FilesystemConfiguration = null,

    /// The updated life cycle configuration for the AgentCore Runtime.
    lifecycle_configuration: ?LifecycleConfiguration = null,

    /// The updated configuration for microVM Metadata Service (MMDS) settings for
    /// the AgentCore Runtime.
    metadata_configuration: ?RuntimeMetadataConfiguration = null,

    /// The updated network configuration for the AgentCore Runtime.
    network_configuration: ?NetworkConfiguration = null,

    /// The updated version of the runtime platform to use for the AgentCore
    /// Runtime.
    platform_version: ?[]const u8 = null,

    protocol_configuration: ?ProtocolConfiguration = null,

    /// The updated configuration for HTTP request headers that will be passed
    /// through to the runtime.
    request_header_configuration: ?RequestHeaderConfiguration = null,

    /// The updated IAM role ARN that provides permissions for the AgentCore
    /// Runtime.
    role_arn: []const u8,

    pub const json_field_names = .{
        .agent_runtime_artifact = "agentRuntimeArtifact",
        .agent_runtime_id = "agentRuntimeId",
        .authorizer_configuration = "authorizerConfiguration",
        .capacity_provider_configuration = "capacityProviderConfiguration",
        .client_token = "clientToken",
        .description = "description",
        .environment_variables = "environmentVariables",
        .filesystem_configurations = "filesystemConfigurations",
        .lifecycle_configuration = "lifecycleConfiguration",
        .metadata_configuration = "metadataConfiguration",
        .network_configuration = "networkConfiguration",
        .platform_version = "platformVersion",
        .protocol_configuration = "protocolConfiguration",
        .request_header_configuration = "requestHeaderConfiguration",
        .role_arn = "roleArn",
    };
};

pub const UpdateAgentRuntimeOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated AgentCore Runtime.
    agent_runtime_arn: []const u8,

    /// The unique identifier of the updated AgentCore Runtime.
    agent_runtime_id: []const u8,

    /// The version of the updated AgentCore Runtime.
    agent_runtime_version: []const u8,

    /// The timestamp when the AgentCore Runtime was created.
    created_at: i64,

    /// The timestamp when the AgentCore Runtime was last updated.
    last_updated_at: i64,

    /// The current status of the updated AgentCore Runtime.
    status: AgentRuntimeStatus,

    /// The workload identity details for the updated AgentCore Runtime.
    workload_identity_details: ?WorkloadIdentityDetails = null,

    pub const json_field_names = .{
        .agent_runtime_arn = "agentRuntimeArn",
        .agent_runtime_id = "agentRuntimeId",
        .agent_runtime_version = "agentRuntimeVersion",
        .created_at = "createdAt",
        .last_updated_at = "lastUpdatedAt",
        .status = "status",
        .workload_identity_details = "workloadIdentityDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAgentRuntimeInput, options: CallOptions) !UpdateAgentRuntimeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAgentRuntimeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/runtimes/");
    try path_buf.appendSlice(allocator, input.agent_runtime_id);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agentRuntimeArtifact\":");
    try aws.json.writeValue(@TypeOf(input.agent_runtime_artifact), input.agent_runtime_artifact, allocator, &body_buf);
    has_prev = true;
    if (input.authorizer_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authorizerConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.capacity_provider_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"capacityProviderConfiguration\":");
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
    if (input.metadata_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"metadataConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.network_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"networkConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.platform_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"platformVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAgentRuntimeOutput {
    const result: UpdateAgentRuntimeOutput = try aws.json.parseJsonObject(
        UpdateAgentRuntimeOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
