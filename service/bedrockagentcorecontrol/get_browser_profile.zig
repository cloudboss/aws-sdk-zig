const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BrowserProfileStatus = @import("browser_profile_status.zig").BrowserProfileStatus;

pub const GetBrowserProfileInput = struct {
    /// The unique identifier of the browser profile to retrieve.
    profile_id: []const u8,

    pub const json_field_names = .{
        .profile_id = "profileId",
    };
};

pub const GetBrowserProfileOutput = struct {
    /// The timestamp when the browser profile was created.
    created_at: i64,

    /// The description of the browser profile.
    description: ?[]const u8 = null,

    /// The timestamp when browser session data was last saved to this profile.
    last_saved_at: ?i64 = null,

    /// The identifier of the browser from which data was last saved to this
    /// profile.
    last_saved_browser_id: ?[]const u8 = null,

    /// The identifier of the browser session from which data was last saved to this
    /// profile.
    last_saved_browser_session_id: ?[]const u8 = null,

    /// The timestamp when the browser profile was last updated.
    last_updated_at: i64,

    /// The name of the browser profile.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the browser profile.
    profile_arn: []const u8,

    /// The unique identifier of the browser profile.
    profile_id: []const u8,

    /// The current status of the browser profile.
    status: BrowserProfileStatus,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .last_saved_at = "lastSavedAt",
        .last_saved_browser_id = "lastSavedBrowserId",
        .last_saved_browser_session_id = "lastSavedBrowserSessionId",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .profile_arn = "profileArn",
        .profile_id = "profileId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBrowserProfileInput, options: CallOptions) !GetBrowserProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBrowserProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/browser-profiles/");
    try path_buf.appendSlice(allocator, input.profile_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBrowserProfileOutput {
    var result: GetBrowserProfileOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetBrowserProfileOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
