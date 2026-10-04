const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserType = @import("user_type.zig").UserType;
const PermissionEntry = @import("permission_entry.zig").PermissionEntry;

pub const ListPermissionsInput = struct {
    /// (Optional) Limits the results to only the group that matches this ID.
    group_id: ?[]const u8 = null,

    /// The maximum number of results to include in the response.
    max_results: ?i32 = null,

    /// The token to use when requesting the next set of results. You received this
    /// token from a previous `ListPermissions` operation.
    next_token: ?[]const u8 = null,

    /// (Optional) Limits the results to only the user that matches this ID.
    user_id: ?[]const u8 = null,

    /// (Optional) If you specify `SSO_USER`, then only the permissions of IAM
    /// Identity Center users are returned. If you specify `SSO_GROUP`, only the
    /// permissions of IAM Identity Center groups are returned.
    user_type: ?UserType = null,

    /// The ID of the workspace to list permissions for. This parameter is required.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .group_id = "groupId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .user_id = "userId",
        .user_type = "userType",
        .workspace_id = "workspaceId",
    };
};

pub const ListPermissionsOutput = struct {
    /// The token to use in a subsequent `ListPermissions` operation to return the
    /// next set of results.
    next_token: ?[]const u8 = null,

    /// The permissions returned by the operation.
    permissions: ?[]const PermissionEntry = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .permissions = "permissions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPermissionsInput, options: CallOptions) !ListPermissionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPermissionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("grafana", "grafana", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/permissions");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.group_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "groupId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.user_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "userId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.user_type) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "userType=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPermissionsOutput {
    const result: ListPermissionsOutput = try aws.json.parseJsonObject(
        ListPermissionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
