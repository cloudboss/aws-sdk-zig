const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserByPermissionGroup = @import("user_by_permission_group.zig").UserByPermissionGroup;

pub const ListUsersByPermissionGroupInput = struct {
    /// The maximum number of results per page.
    max_results: i32,

    /// A token that indicates where a results page should begin.
    next_token: ?[]const u8 = null,

    /// The unique identifier for the permission group.
    permission_group_id: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .permission_group_id = "permissionGroupId",
    };
};

pub const ListUsersByPermissionGroupOutput = struct {
    /// A token that indicates where a results page should begin.
    next_token: ?[]const u8 = null,

    /// Lists details of all users in a specific permission group.
    users: ?[]const UserByPermissionGroup = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .users = "users",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListUsersByPermissionGroupInput, options: CallOptions) !ListUsersByPermissionGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "finspace-api", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListUsersByPermissionGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("finspace-api", "finspace data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/permission-group/");
    try path_buf.appendSlice(allocator, input.permission_group_id);
    try path_buf.appendSlice(allocator, "/users");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "maxResults=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.max_results}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListUsersByPermissionGroupOutput {
    var result: ListUsersByPermissionGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListUsersByPermissionGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
