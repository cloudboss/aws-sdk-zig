const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetUserInput = struct {
    /// The end time for filtering the user's last activity. Only activity before
    /// this timestamp will be considered. Time is specified in epoch seconds.
    end_time: ?i64 = null,

    /// The ID of the Wickr network containing the user.
    network_id: []const u8,

    /// The start time for filtering the user's last activity. Only activity after
    /// this timestamp will be considered. Time is specified in epoch seconds.
    start_time: ?i64 = null,

    /// The unique identifier of the user to retrieve.
    user_id: []const u8,

    pub const json_field_names = .{
        .end_time = "endTime",
        .network_id = "networkId",
        .start_time = "startTime",
        .user_id = "userId",
    };
};

pub const GetUserOutput = struct {
    /// The first name of the user.
    first_name: ?[]const u8 = null,

    /// Indicates whether the user has administrator privileges in the network.
    is_admin: ?bool = null,

    /// The timestamp of the user's last activity in the network, specified in epoch
    /// seconds.
    last_activity: ?i32 = null,

    /// The timestamp of the user's last login to the network, specified in epoch
    /// seconds.
    last_login: ?i32 = null,

    /// The last name of the user.
    last_name: ?[]const u8 = null,

    /// A list of security group IDs to which the user belongs.
    security_group_ids: ?[]const []const u8 = null,

    /// The current status of the user (1 for pending, 2 for active).
    status: ?i32 = null,

    /// Indicates whether the user is currently suspended.
    suspended: ?bool = null,

    /// The unique identifier of the user.
    user_id: []const u8,

    /// The email address or username of the user.
    username: ?[]const u8 = null,

    pub const json_field_names = .{
        .first_name = "firstName",
        .is_admin = "isAdmin",
        .last_activity = "lastActivity",
        .last_login = "lastLogin",
        .last_name = "lastName",
        .security_group_ids = "securityGroupIds",
        .status = "status",
        .suspended = "suspended",
        .user_id = "userId",
        .username = "username",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUserInput, options: CallOptions) !GetUserOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wickr", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("admin.wickr", "Wickr", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/users/");
    try path_buf.appendSlice(allocator, input.user_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.end_time) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "endTime=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.start_time) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "startTime=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUserOutput {
    const result: GetUserOutput = try aws.json.parseJsonObject(
        GetUserOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
