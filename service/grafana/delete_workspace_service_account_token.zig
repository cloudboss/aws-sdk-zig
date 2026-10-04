const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteWorkspaceServiceAccountTokenInput = struct {
    /// The ID of the service account from which to delete the token.
    service_account_id: []const u8,

    /// The ID of the token to delete.
    token_id: []const u8,

    /// The ID of the workspace from which to delete the token.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .service_account_id = "serviceAccountId",
        .token_id = "tokenId",
        .workspace_id = "workspaceId",
    };
};

pub const DeleteWorkspaceServiceAccountTokenOutput = struct {
    /// The ID of the service account where the token was deleted.
    service_account_id: []const u8,

    /// The ID of the token that was deleted.
    token_id: []const u8,

    /// The ID of the workspace where the token was deleted.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .service_account_id = "serviceAccountId",
        .token_id = "tokenId",
        .workspace_id = "workspaceId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteWorkspaceServiceAccountTokenInput, options: CallOptions) !DeleteWorkspaceServiceAccountTokenOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteWorkspaceServiceAccountTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("grafana", "grafana", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/serviceaccounts/");
    try path_buf.appendSlice(allocator, input.service_account_id);
    try path_buf.appendSlice(allocator, "/tokens/");
    try path_buf.appendSlice(allocator, input.token_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteWorkspaceServiceAccountTokenOutput {
    var result: DeleteWorkspaceServiceAccountTokenOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteWorkspaceServiceAccountTokenOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
