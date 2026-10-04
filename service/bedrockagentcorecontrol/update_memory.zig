const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IndexedKey = @import("indexed_key.zig").IndexedKey;
const ModifyMemoryStrategies = @import("modify_memory_strategies.zig").ModifyMemoryStrategies;
const NamespaceKeyEntry = @import("namespace_key_entry.zig").NamespaceKeyEntry;
const StreamDeliveryResources = @import("stream_delivery_resources.zig").StreamDeliveryResources;
const Memory = @import("memory.zig").Memory;

pub const UpdateMemoryInput = struct {
    /// Additional metadata keys to index. Previously indexed keys cannot be
    /// removed.
    add_indexed_keys: ?[]const IndexedKey = null,

    /// A client token is used for keeping track of idempotent requests. It can
    /// contain a session id which can be around 250 chars, combined with a unique
    /// AWS identifier.
    client_token: ?[]const u8 = null,

    /// The updated description of the AgentCore Memory resource.
    description: ?[]const u8 = null,

    /// The number of days after which memory events will expire, between 7 and 365
    /// days.
    event_expiry_duration: ?i32 = null,

    /// The ARN of the IAM role that provides permissions for the AgentCore Memory
    /// resource.
    memory_execution_role_arn: ?[]const u8 = null,

    /// The unique identifier of the memory to update.
    memory_id: []const u8,

    /// The memory strategies to add, modify, or delete.
    memory_strategies: ?ModifyMemoryStrategies = null,

    /// The namespace variable key definitions with validation rules for this
    /// memory. This value fully replaces the existing set — any key you omit is
    /// removed. Any referenced `namespaceKey` omission will throw
    /// ValidationException.
    namespace_keys: ?[]const NamespaceKeyEntry = null,

    /// Configuration for streaming memory record data to external resources.
    stream_delivery_resources: ?StreamDeliveryResources = null,

    pub const json_field_names = .{
        .add_indexed_keys = "addIndexedKeys",
        .client_token = "clientToken",
        .description = "description",
        .event_expiry_duration = "eventExpiryDuration",
        .memory_execution_role_arn = "memoryExecutionRoleArn",
        .memory_id = "memoryId",
        .memory_strategies = "memoryStrategies",
        .namespace_keys = "namespaceKeys",
        .stream_delivery_resources = "streamDeliveryResources",
    };
};

pub const UpdateMemoryOutput = struct {
    /// The updated AgentCore Memory resource details.
    memory: ?Memory = null,

    pub const json_field_names = .{
        .memory = "memory",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMemoryInput, options: CallOptions) !UpdateMemoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMemoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memories/");
    try path_buf.appendSlice(allocator, input.memory_id);
    try path_buf.appendSlice(allocator, "/update");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.add_indexed_keys) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"addIndexedKeys\":");
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
    if (input.event_expiry_duration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"eventExpiryDuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.memory_execution_role_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"memoryExecutionRoleArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.memory_strategies) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"memoryStrategies\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.namespace_keys) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"namespaceKeys\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stream_delivery_resources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"streamDeliveryResources\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMemoryOutput {
    const result: UpdateMemoryOutput = try aws.json.parseJsonObject(
        UpdateMemoryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
