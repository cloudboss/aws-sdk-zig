const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TokenProviders = @import("token_providers.zig").TokenProviders;
const ExchangeCodeForTokenRequestBody = @import("exchange_code_for_token_request_body.zig").ExchangeCodeForTokenRequestBody;

pub const ExchangeCodeForTokenInput = struct {
    /// The third-party provider for the token. The only valid value is `figma`.
    provider: TokenProviders,

    /// Describes the configuration of the request.
    request: ExchangeCodeForTokenRequestBody,

    pub const json_field_names = .{
        .provider = "provider",
        .request = "request",
    };
};

pub const ExchangeCodeForTokenOutput = struct {
    /// The access token.
    access_token: []const u8,

    /// The date and time when the new access token expires.
    expires_in: i32,

    /// The token to use to refresh a previously issued access token that might have
    /// expired.
    refresh_token: []const u8,

    pub const json_field_names = .{
        .access_token = "accessToken",
        .expires_in = "expiresIn",
        .refresh_token = "refreshToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ExchangeCodeForTokenInput, options: CallOptions) !ExchangeCodeForTokenOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amplifyuibuilder", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ExchangeCodeForTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("amplifyuibuilder", "AmplifyUIBuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/tokens/");
    try path_buf.appendSlice(allocator, input.provider);
    const path = try path_buf.toOwnedSlice(allocator);

    const body = try aws.json.jsonStringify(input.request, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ExchangeCodeForTokenOutput {
    const result: ExchangeCodeForTokenOutput = try aws.json.parseJsonObject(
        ExchangeCodeForTokenOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
