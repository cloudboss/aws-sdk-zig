const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LimitEntry = @import("limit_entry.zig").LimitEntry;
const GatewayRateLimitStatus = @import("gateway_rate_limit_status.zig").GatewayRateLimitStatus;

pub const GetGatewayRateLimitInput = struct {
    /// The unique identifier of the gateway.
    gateway_identifier: []const u8,

    /// The unique identifier of the rate limit to retrieve.
    rate_limit_id: []const u8,

    pub const json_field_names = .{
        .gateway_identifier = "gatewayIdentifier",
        .rate_limit_id = "rateLimitId",
    };
};

pub const GetGatewayRateLimitOutput = struct {
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

    /// The unique identifier of the rate limit.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGatewayRateLimitInput, options: CallOptions) !GetGatewayRateLimitOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGatewayRateLimitInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/gateways/");
    try path_buf.appendSlice(allocator, input.gateway_identifier);
    try path_buf.appendSlice(allocator, "/rate-limits/");
    try path_buf.appendSlice(allocator, input.rate_limit_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGatewayRateLimitOutput {
    const result: GetGatewayRateLimitOutput = try aws.json.parseJsonObject(
        GetGatewayRateLimitOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
