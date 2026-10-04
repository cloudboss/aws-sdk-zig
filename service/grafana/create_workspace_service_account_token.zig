const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceAccountTokenSummaryWithKey = @import("service_account_token_summary_with_key.zig").ServiceAccountTokenSummaryWithKey;

pub const CreateWorkspaceServiceAccountTokenInput = struct {
    /// A name for the token to create.
    name: []const u8,

    /// Sets how long the token will be valid, in seconds. You can set the time up
    /// to 30 days in the future.
    seconds_to_live: i32,

    /// The ID of the service account for which to create a token.
    service_account_id: []const u8,

    /// The ID of the workspace the service account resides within.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .name = "name",
        .seconds_to_live = "secondsToLive",
        .service_account_id = "serviceAccountId",
        .workspace_id = "workspaceId",
    };
};

pub const CreateWorkspaceServiceAccountTokenOutput = struct {
    /// The ID of the service account where the token was created.
    service_account_id: []const u8,

    /// Information about the created token, including the key. Be sure to store the
    /// key securely.
    service_account_token: ?ServiceAccountTokenSummaryWithKey = null,

    /// The ID of the workspace where the token was created.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .service_account_id = "serviceAccountId",
        .service_account_token = "serviceAccountToken",
        .workspace_id = "workspaceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkspaceServiceAccountTokenInput, options: CallOptions) !CreateWorkspaceServiceAccountTokenOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkspaceServiceAccountTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("grafana", "grafana", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/serviceaccounts/");
    try path_buf.appendSlice(allocator, input.service_account_id);
    try path_buf.appendSlice(allocator, "/tokens");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkspaceServiceAccountTokenOutput {
    const result: CreateWorkspaceServiceAccountTokenOutput = try aws.json.parseJsonObject(
        CreateWorkspaceServiceAccountTokenOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
