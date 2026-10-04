const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BrowserProfileStatus = @import("browser_profile_status.zig").BrowserProfileStatus;

pub const DeleteBrowserProfileInput = struct {
    /// A unique, case-sensitive identifier to ensure idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The unique identifier of the browser profile to delete.
    profile_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .profile_id = "profileId",
    };
};

pub const DeleteBrowserProfileOutput = struct {
    /// The timestamp when browser session data was last saved to this profile
    /// before deletion.
    last_saved_at: ?i64 = null,

    /// The timestamp when the browser profile was last updated.
    last_updated_at: i64,

    /// The Amazon Resource Name (ARN) of the deleted browser profile.
    profile_arn: []const u8,

    /// The unique identifier of the deleted browser profile.
    profile_id: []const u8,

    /// The current status of the browser profile deletion.
    status: BrowserProfileStatus,

    pub const json_field_names = .{
        .last_saved_at = "lastSavedAt",
        .last_updated_at = "lastUpdatedAt",
        .profile_arn = "profileArn",
        .profile_id = "profileId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteBrowserProfileInput, options: CallOptions) !DeleteBrowserProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteBrowserProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/browser-profiles/");
    try path_buf.appendSlice(allocator, input.profile_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.client_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clientToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteBrowserProfileOutput {
    const result: DeleteBrowserProfileOutput = try aws.json.parseJsonObject(
        DeleteBrowserProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
