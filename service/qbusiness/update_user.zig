const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserAlias = @import("user_alias.zig").UserAlias;

pub const UpdateUserInput = struct {
    /// The identifier of the application the user is attached to.
    application_id: []const u8,

    /// The user aliases attached to the user id that are to be deleted.
    user_aliases_to_delete: ?[]const UserAlias = null,

    /// The user aliases attached to the user id that are to be updated.
    user_aliases_to_update: ?[]const UserAlias = null,

    /// The email id attached to the user.
    user_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .user_aliases_to_delete = "userAliasesToDelete",
        .user_aliases_to_update = "userAliasesToUpdate",
        .user_id = "userId",
    };
};

pub const UpdateUserOutput = struct {
    /// The user aliases that have been to be added to a user id.
    user_aliases_added: ?[]const UserAlias = null,

    /// The user aliases that have been deleted from a user id.
    user_aliases_deleted: ?[]const UserAlias = null,

    /// The user aliases attached to a user id that have been updated.
    user_aliases_updated: ?[]const UserAlias = null,

    pub const json_field_names = .{
        .user_aliases_added = "userAliasesAdded",
        .user_aliases_deleted = "userAliasesDeleted",
        .user_aliases_updated = "userAliasesUpdated",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateUserInput, options: CallOptions) !UpdateUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/users/");
    try path_buf.appendSlice(allocator, input.user_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.user_aliases_to_delete) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"userAliasesToDelete\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.user_aliases_to_update) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"userAliasesToUpdate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateUserOutput {
    const result: UpdateUserOutput = try aws.json.parseJsonObject(
        UpdateUserOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
