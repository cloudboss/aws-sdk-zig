const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AgentRuntimeEndpointStatus = @import("agent_runtime_endpoint_status.zig").AgentRuntimeEndpointStatus;

pub const CreateAgentRuntimeEndpointInput = struct {
    /// The unique identifier of the AgentCore Runtime to create an endpoint for.
    agent_runtime_id: []const u8,

    /// The version of the AgentCore Runtime to use for the endpoint.
    agent_runtime_version: ?[]const u8 = null,

    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The description of the AgentCore Runtime endpoint.
    description: ?[]const u8 = null,

    /// The name of the AgentCore Runtime endpoint.
    name: []const u8,

    /// A map of tag keys and values to assign to the agent runtime endpoint. Tags
    /// enable you to categorize your resources in different ways, for example, by
    /// purpose, owner, or environment.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .agent_runtime_id = "agentRuntimeId",
        .agent_runtime_version = "agentRuntimeVersion",
        .client_token = "clientToken",
        .description = "description",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateAgentRuntimeEndpointOutput = struct {
    /// The Amazon Resource Name (ARN) of the AgentCore Runtime.
    agent_runtime_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the AgentCore Runtime endpoint.
    agent_runtime_endpoint_arn: []const u8,

    /// The unique identifier of the AgentCore Runtime.
    agent_runtime_id: ?[]const u8 = null,

    /// The timestamp when the AgentCore Runtime endpoint was created.
    created_at: i64,

    /// The name of the AgentCore Runtime endpoint.
    endpoint_name: ?[]const u8 = null,

    /// The current status of the AgentCore Runtime endpoint.
    status: AgentRuntimeEndpointStatus,

    /// The target version of the AgentCore Runtime for the endpoint.
    target_version: []const u8,

    pub const json_field_names = .{
        .agent_runtime_arn = "agentRuntimeArn",
        .agent_runtime_endpoint_arn = "agentRuntimeEndpointArn",
        .agent_runtime_id = "agentRuntimeId",
        .created_at = "createdAt",
        .endpoint_name = "endpointName",
        .status = "status",
        .target_version = "targetVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAgentRuntimeEndpointInput, options: CallOptions) !CreateAgentRuntimeEndpointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAgentRuntimeEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/runtimes/");
    try path_buf.appendSlice(allocator, input.agent_runtime_id);
    try path_buf.appendSlice(allocator, "/runtime-endpoints/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.agent_runtime_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"agentRuntimeVersion\":");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAgentRuntimeEndpointOutput {
    var result: CreateAgentRuntimeEndpointOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateAgentRuntimeEndpointOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
