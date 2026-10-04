const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetTokenInput = struct {
    /// The app ID.
    app_id: []const u8,

    /// The session ID.
    session_id: []const u8,

    pub const json_field_names = .{
        .app_id = "AppId",
        .session_id = "SessionId",
    };
};

pub const GetTokenOutput = struct {
    /// The app ID.
    app_id: ?[]const u8 = null,

    /// The one-time challenge code for authenticating into the Amplify Admin UI.
    challenge_code: ?[]const u8 = null,

    /// A unique ID provided when creating a new challenge token.
    session_id: ?[]const u8 = null,

    /// The expiry time for the one-time generated token code.
    ttl: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_id = "AppId",
        .challenge_code = "ChallengeCode",
        .session_id = "SessionId",
        .ttl = "Ttl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTokenInput, options: CallOptions) !GetTokenOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amplifybackend", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("amplifybackend", "AmplifyBackend", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/backend/");
    try path_buf.appendSlice(allocator, input.app_id);
    try path_buf.appendSlice(allocator, "/challenge/");
    try path_buf.appendSlice(allocator, input.session_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTokenOutput {
    const result: GetTokenOutput = try aws.json.parseJsonObject(
        GetTokenOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
