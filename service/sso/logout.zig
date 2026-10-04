const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const LogoutInput = struct {
    /// The token issued by the `CreateToken` API call. For more information, see
    /// [CreateToken](https://docs.aws.amazon.com/singlesignon/latest/OIDCAPIReference/API_CreateToken.html) in the *IAM Identity Center OIDC API Reference Guide*.
    access_token: []const u8,

    pub const json_field_names = .{
        .access_token = "accessToken",
    };
};

pub const LogoutOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: LogoutInput, options: CallOptions) !LogoutOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsssoportal", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: LogoutInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("portal.sso", "SSO", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/logout";

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "x-amz-sso_bearer_token", input.access_token);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !LogoutOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: LogoutOutput = .{};

    return result;
}
