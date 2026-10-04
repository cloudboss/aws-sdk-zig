const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IndexedKey = @import("indexed_key.zig").IndexedKey;
const MemoryStrategyInput = @import("memory_strategy_input.zig").MemoryStrategyInput;
const StreamDeliveryResources = @import("stream_delivery_resources.zig").StreamDeliveryResources;
const Memory = @import("memory.zig").Memory;

pub const CreateMemoryInput = struct {
    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request but does not return an error.
    client_token: ?[]const u8 = null,

    /// The description of the memory.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the memory
    /// data.
    encryption_key_arn: ?[]const u8 = null,

    /// The duration after which memory events expire. Specified as an ISO 8601
    /// duration.
    event_expiry_duration: i32,

    /// Metadata keys to index for filtering. Once declared, indexed keys cannot be
    /// removed.
    indexed_keys: ?[]const IndexedKey = null,

    /// The Amazon Resource Name (ARN) of the IAM role that provides permissions for
    /// the memory to access Amazon Web Services services.
    memory_execution_role_arn: ?[]const u8 = null,

    /// The memory strategies to use for this memory. Strategies define how
    /// information is extracted, processed, and consolidated.
    memory_strategies: ?[]const MemoryStrategyInput = null,

    /// The name of the memory. The name must be unique within your account.
    name: []const u8,

    /// Configuration for streaming memory record data to external resources.
    stream_delivery_resources: ?StreamDeliveryResources = null,

    /// A map of tag keys and values to assign to an AgentCore Memory. Tags enable
    /// you to categorize your resources in different ways, for example, by purpose,
    /// owner, or environment.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .encryption_key_arn = "encryptionKeyArn",
        .event_expiry_duration = "eventExpiryDuration",
        .indexed_keys = "indexedKeys",
        .memory_execution_role_arn = "memoryExecutionRoleArn",
        .memory_strategies = "memoryStrategies",
        .name = "name",
        .stream_delivery_resources = "streamDeliveryResources",
        .tags = "tags",
    };
};

pub const CreateMemoryOutput = struct {
    /// The details of the created memory, including its ID, ARN, name, description,
    /// and configuration settings.
    memory: ?Memory = null,

    pub const json_field_names = .{
        .memory = "memory",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMemoryInput, options: CallOptions) !CreateMemoryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMemoryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/memories/create";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

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
    if (input.encryption_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"encryptionKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"eventExpiryDuration\":");
    try aws.json.writeValue(@TypeOf(input.event_expiry_duration), input.event_expiry_duration, allocator, &body_buf);
    has_prev = true;
    if (input.indexed_keys) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"indexedKeys\":");
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.stream_delivery_resources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"streamDeliveryResources\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMemoryOutput {
    var result: CreateMemoryOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateMemoryOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
