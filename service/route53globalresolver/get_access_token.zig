const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TokenStatus = @import("token_status.zig").TokenStatus;

pub const GetAccessTokenInput = struct {
    /// ID of the token.
    access_token_id: []const u8,

    pub const json_field_names = .{
        .access_token_id = "accessTokenId",
    };
};

pub const GetAccessTokenOutput = struct {
    /// The Amazon Resource Name (ARN) of the token.
    arn: []const u8,

    /// A unique, case-sensitive identifier to ensure idempotency. This means that
    /// making the same request multiple times with the same `clientToken` has the
    /// same result every time.
    client_token: ?[]const u8 = null,

    /// The time and date the token was created.
    created_at: i64,

    /// ID of the DNS view the token is associated to.
    dns_view_id: []const u8,

    /// The token's expiration time and date.
    expires_at: i64,

    /// ID of the Global Resolver.
    global_resolver_id: []const u8,

    /// ID of the token.
    id: []const u8,

    /// Name of the token.
    name: ?[]const u8 = null,

    /// The operational status of the token.
    status: TokenStatus,

    /// The time and date the token was created.
    updated_at: i64,

    /// The value of the token.
    value: []const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .client_token = "clientToken",
        .created_at = "createdAt",
        .dns_view_id = "dnsViewId",
        .expires_at = "expiresAt",
        .global_resolver_id = "globalResolverId",
        .id = "id",
        .name = "name",
        .status = "status",
        .updated_at = "updatedAt",
        .value = "value",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAccessTokenInput, options: CallOptions) !GetAccessTokenOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccessTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53globalresolver", "Route53GlobalResolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/tokens/");
    try path_buf.appendSlice(allocator, input.access_token_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccessTokenOutput {
    var result: GetAccessTokenOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetAccessTokenOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
