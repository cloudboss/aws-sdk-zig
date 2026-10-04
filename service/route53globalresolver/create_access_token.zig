const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TokenStatus = @import("token_status.zig").TokenStatus;

pub const CreateAccessTokenInput = struct {
    /// A unique, case-sensitive identifier to ensure idempotency. This means that
    /// making the same request multiple times with the same `clientToken` has the
    /// same result every time.
    client_token: ?[]const u8 = null,

    /// The ID of the DNS view to associate with this token.
    dns_view_id: []const u8,

    /// The date and time when the token expires. Tokens can have a minimum
    /// expiration of 30 days and maximum of 365 days from creation.
    expires_at: ?i64 = null,

    /// A descriptive name for the access token.
    name: ?[]const u8 = null,

    /// An array of user-defined keys and optional values. These tags can be used
    /// for categorization and organization.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .dns_view_id = "dnsViewId",
        .expires_at = "expiresAt",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateAccessTokenOutput = struct {
    /// The Amazon Resource Name (ARN) of the access token.
    arn: []const u8,

    /// The unique string that identifies the request and ensures idempotency.
    client_token: ?[]const u8 = null,

    /// The date and time when the access token was created.
    created_at: i64,

    /// The ID of the DNS view associated with this access token.
    dns_view_id: []const u8,

    /// The date and time when the access token expires.
    expires_at: i64,

    /// The unique identifier for the access token.
    id: []const u8,

    /// The name of the access token.
    name: ?[]const u8 = null,

    /// The operational status of the access token.
    status: TokenStatus,

    /// The access token value. This token should be included in DoH and DoT
    /// requests for authentication. Keep this value secure as it provides access to
    /// your Route 53 Global Resolver.
    value: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .client_token = "clientToken",
        .created_at = "createdAt",
        .dns_view_id = "dnsViewId",
        .expires_at = "expiresAt",
        .id = "id",
        .name = "name",
        .status = "status",
        .value = "value",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAccessTokenInput, options: CallOptions) !CreateAccessTokenOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53globalresolver", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAccessTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/tokens/");
    try path_buf.appendSlice(allocator, input.dns_view_id);
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
    if (input.expires_at) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"expiresAt\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAccessTokenOutput {
    const result: CreateAccessTokenOutput = try aws.json.parseJsonObject(
        CreateAccessTokenOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
