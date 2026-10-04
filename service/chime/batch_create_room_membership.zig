const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MembershipItem = @import("membership_item.zig").MembershipItem;
const MemberError = @import("member_error.zig").MemberError;

pub const BatchCreateRoomMembershipInput = struct {
    /// The Amazon Chime account ID.
    account_id: []const u8,

    /// The list of membership items.
    membership_item_list: []const MembershipItem,

    /// The room ID.
    room_id: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .membership_item_list = "MembershipItemList",
        .room_id = "RoomId",
    };
};

pub const BatchCreateRoomMembershipOutput = struct {
    /// If the action fails for one or more of the member IDs in the request, a list
    /// of the member IDs is returned, along with error codes and error messages.
    errors: ?[]const MemberError = null,

    pub const json_field_names = .{
        .errors = "Errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchCreateRoomMembershipInput, options: CallOptions) !BatchCreateRoomMembershipOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchCreateRoomMembershipInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("chime", "Chime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.account_id);
    try path_buf.appendSlice(allocator, "/rooms/");
    try path_buf.appendSlice(allocator, input.room_id);
    try path_buf.appendSlice(allocator, "/memberships");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "operation=batch-create");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MembershipItemList\":");
    try aws.json.writeValue(@TypeOf(input.membership_item_list), input.membership_item_list, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchCreateRoomMembershipOutput {
    var result: BatchCreateRoomMembershipOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchCreateRoomMembershipOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
