const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkspaceStatus = @import("workspace_status.zig").WorkspaceStatus;

pub const DeleteWorkspaceInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure that the
    /// request is
    /// idempotent. If you retry a request that completed successfully using the
    /// same client token,
    /// the retry succeeds without performing any further actions.
    client_token: ?[]const u8 = null,

    /// The name of the workspace to delete.
    workspace_name: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .workspace_name = "workspaceName",
    };
};

pub const DeleteWorkspaceOutput = struct {
    /// The status of the workspace after the deletion request, which is `DELETING`
    /// when the operation returns.
    workspace_status: ?WorkspaceStatus = null,

    pub const json_field_names = .{
        .workspace_status = "workspaceStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteWorkspaceInput, options: CallOptions) !DeleteWorkspaceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteWorkspaceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteWorkspaceOutput {
    const result: DeleteWorkspaceOutput = try aws.json.parseJsonObject(
        DeleteWorkspaceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
