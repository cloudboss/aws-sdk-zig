const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserError = @import("user_error.zig").UserError;

pub const BatchSuspendUserInput = struct {
    /// The Amazon Chime account ID.
    account_id: []const u8,

    /// The request containing the user IDs to suspend.
    user_id_list: []const []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .user_id_list = "UserIdList",
    };
};

pub const BatchSuspendUserOutput = struct {
    /// If the BatchSuspendUser action fails for one or more of the user IDs in the
    /// request, a list of the user IDs is returned, along with error codes and
    /// error messages.
    user_errors: ?[]const UserError = null,

    pub const json_field_names = .{
        .user_errors = "UserErrors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchSuspendUserInput, options: CallOptions) !BatchSuspendUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchSuspendUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chime", "Chime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.account_id);
    try path_buf.appendSlice(allocator, "/users");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "operation=suspend");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"UserIdList\":");
    try aws.json.writeValue(@TypeOf(input.user_id_list), input.user_id_list, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchSuspendUserOutput {
    var result: BatchSuspendUserOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchSuspendUserOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
