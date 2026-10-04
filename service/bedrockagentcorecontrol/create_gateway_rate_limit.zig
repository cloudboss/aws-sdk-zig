const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LimitEntry = @import("limit_entry.zig").LimitEntry;
const GatewayRateLimitStatus = @import("gateway_rate_limit_status.zig").GatewayRateLimitStatus;

pub const CreateGatewayRateLimitInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If you don't specify this field, a value is randomly
    /// generated for you. If this token matches a previous request, the service
    /// ignores the request, but doesn't return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// An optional human-readable description for this rate limit. If not provided,
    /// the rate limit is created without a description.
    description: ?[]const u8 = null,

    /// The ordered list of dimension key names that define the scope of this rate
    /// limit. Must be unique per gateway—no two rate limits can share the same
    /// dimension keys.
    dimension_keys: []const []const u8,

    /// The rule entries that map dimension values to rate configurations.
    entries: []const LimitEntry,

    /// The unique identifier of the gateway to create the rate limit for.
    gateway_identifier: []const u8,

    /// An optional customer-defined identifier for the rate limit. If not provided,
    /// the system generates one.
    rate_limit_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .dimension_keys = "dimensionKeys",
        .entries = "entries",
        .gateway_identifier = "gatewayIdentifier",
        .rate_limit_id = "rateLimitId",
    };
};

pub const CreateGatewayRateLimitOutput = struct {
    /// The timestamp when the rate limit was created.
    created_at: i64,

    /// The human-readable description of the rate limit.
    description: ?[]const u8 = null,

    /// The ordered list of dimension key names that define the scope of this rate
    /// limit.
    dimension_keys: ?[]const []const u8 = null,

    /// The list of rule entries that map dimension values to rate configurations.
    entries: ?[]const LimitEntry = null,

    /// The unique identifier of the gateway.
    gateway_identifier: []const u8,

    /// The unique identifier of the created rate limit.
    rate_limit_id: []const u8,

    /// The current status of the rate limit.
    status: GatewayRateLimitStatus,

    /// The timestamp when the rate limit was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .dimension_keys = "dimensionKeys",
        .entries = "entries",
        .gateway_identifier = "gatewayIdentifier",
        .rate_limit_id = "rateLimitId",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGatewayRateLimitInput, options: CallOptions) !CreateGatewayRateLimitOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGatewayRateLimitInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/gateways/");
    try path_buf.appendSlice(allocator, input.gateway_identifier);
    try path_buf.appendSlice(allocator, "/rate-limits");
    const path = try path_buf.toOwnedSlice(allocator);

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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dimensionKeys\":");
    try aws.json.writeValue(@TypeOf(input.dimension_keys), input.dimension_keys, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"entries\":");
    try aws.json.writeValue(@TypeOf(input.entries), input.entries, allocator, &body_buf);
    has_prev = true;
    if (input.rate_limit_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"rateLimitId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGatewayRateLimitOutput {
    const result: CreateGatewayRateLimitOutput = try aws.json.parseJsonObject(
        CreateGatewayRateLimitOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
