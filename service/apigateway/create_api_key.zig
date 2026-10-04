const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StageKey = @import("stage_key.zig").StageKey;

pub const CreateApiKeyInput = struct {
    /// An Amazon Web Services Marketplace customer identifier, when integrating
    /// with the Amazon Web Services SaaS Marketplace.
    customer_id: ?[]const u8 = null,

    /// The description of the ApiKey.
    description: ?[]const u8 = null,

    /// Specifies whether the ApiKey can be used by callers.
    enabled: ?bool = null,

    /// Specifies whether (`true`) or not (`false`) the key identifier is distinct
    /// from the created API key value. This parameter is deprecated and should not
    /// be used.
    generate_distinct_id: ?bool = null,

    /// The name of the ApiKey.
    name: ?[]const u8 = null,

    /// DEPRECATED FOR USAGE PLANS - Specifies stages associated with the API key.
    stage_keys: ?[]const StageKey = null,

    /// The key-value map of strings. The valid character set is [a-zA-Z+-=._:/].
    /// The tag key can be up to 128 characters and must not start with `aws:`. The
    /// tag value can be up to 256 characters.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Specifies a value of the API key.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .customer_id = "customerId",
        .description = "description",
        .enabled = "enabled",
        .generate_distinct_id = "generateDistinctId",
        .name = "name",
        .stage_keys = "stageKeys",
        .tags = "tags",
        .value = "value",
    };
};

pub const CreateApiKeyOutput = @import("api_key.zig").ApiKey;

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApiKeyInput, options: CallOptions) !CreateApiKeyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateApiKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/apikeys";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.customer_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customerId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.generate_distinct_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"generateDistinctId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stage_keys) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"stageKeys\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.value) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"value\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateApiKeyOutput {
    const result: CreateApiKeyOutput = try aws.json.parseJsonObject(
        CreateApiKeyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
