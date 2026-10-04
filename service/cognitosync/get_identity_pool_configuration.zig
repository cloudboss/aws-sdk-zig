const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CognitoStreams = @import("cognito_streams.zig").CognitoStreams;
const PushSync = @import("push_sync.zig").PushSync;

pub const GetIdentityPoolConfigurationInput = struct {
    /// A name-spaced GUID (for example,
    /// us-east-1:23EC4050-6AEA-7089-A2DD-08002EXAMPLE) created by
    /// Amazon Cognito. This is the ID of the pool for which to return a
    /// configuration.
    identity_pool_id: []const u8,

    pub const json_field_names = .{
        .identity_pool_id = "IdentityPoolId",
    };
};

pub const GetIdentityPoolConfigurationOutput = struct {
    /// Options to apply to this identity pool for Amazon Cognito streams.
    cognito_streams: ?CognitoStreams = null,

    /// A name-spaced GUID (for example,
    /// us-east-1:23EC4050-6AEA-7089-A2DD-08002EXAMPLE) created by
    /// Amazon Cognito.
    identity_pool_id: ?[]const u8 = null,

    /// Options to apply to this identity pool for push synchronization.
    push_sync: ?PushSync = null,

    pub const json_field_names = .{
        .cognito_streams = "CognitoStreams",
        .identity_pool_id = "IdentityPoolId",
        .push_sync = "PushSync",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetIdentityPoolConfigurationInput, options: CallOptions) !GetIdentityPoolConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cognito-sync", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetIdentityPoolConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cognito-sync", "Cognito Sync", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/identitypools/");
    try path_buf.appendSlice(allocator, input.identity_pool_id);
    try path_buf.appendSlice(allocator, "/configuration");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetIdentityPoolConfigurationOutput {
    var result: GetIdentityPoolConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetIdentityPoolConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
