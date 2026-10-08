const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RevokeOAuth2TokenWithIAMInput = struct {
    /// The refresh_token to revoke. Must be a refresh_token issued by AWS
    /// Sign-In (prefix "ASOR"); access_tokens are not accepted for revocation.
    token: []const u8,

    pub const json_field_names = .{
        .token = "token",
    };
};

pub const RevokeOAuth2TokenWithIAMOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RevokeOAuth2TokenWithIAMInput, options: CallOptions) !RevokeOAuth2TokenWithIAMOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "signin", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RevokeOAuth2TokenWithIAMInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("signin", "Signin", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/revoke";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "x-amz-client-auth-method=iam");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"token\":");
    try aws.json.writeValue(@TypeOf(input.token), input.token, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RevokeOAuth2TokenWithIAMOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: RevokeOAuth2TokenWithIAMOutput = .{};

    return result;
}
