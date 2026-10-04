const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateWorkspaceApiKeyInput = struct {
    /// Specifies the name of the key. Keynames must be unique to the workspace.
    key_name: []const u8,

    /// Specifies the permission level of the key.
    ///
    /// Valid values: `ADMIN`|`EDITOR`|`VIEWER`
    key_role: []const u8,

    /// Specifies the time in seconds until the key expires. Keys can be valid for
    /// up to 30 days.
    seconds_to_live: i32,

    /// The ID of the workspace to create an API key.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .key_name = "keyName",
        .key_role = "keyRole",
        .seconds_to_live = "secondsToLive",
        .workspace_id = "workspaceId",
    };
};

pub const CreateWorkspaceApiKeyOutput = struct {
    /// The key token. Use this value as a bearer token to authenticate HTTP
    /// requests to the workspace.
    key: []const u8,

    /// The name of the key that was created.
    key_name: []const u8,

    /// The ID of the workspace that the key is valid for.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .key = "key",
        .key_name = "keyName",
        .workspace_id = "workspaceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkspaceApiKeyInput, options: CallOptions) !CreateWorkspaceApiKeyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "grafana", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkspaceApiKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("grafana", "grafana", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/apikeys");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"keyName\":");
    try aws.json.writeValue(@TypeOf(input.key_name), input.key_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"keyRole\":");
    try aws.json.writeValue(@TypeOf(input.key_role), input.key_role, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"secondsToLive\":");
    try aws.json.writeValue(@TypeOf(input.seconds_to_live), input.seconds_to_live, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkspaceApiKeyOutput {
    const result: CreateWorkspaceApiKeyOutput = try aws.json.parseJsonObject(
        CreateWorkspaceApiKeyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
