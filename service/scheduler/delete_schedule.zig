const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteScheduleInput = struct {
    /// Unique, case-sensitive identifier you provide to ensure the idempotency of
    /// the request. If you do not specify a client token,
    /// EventBridge Scheduler uses a randomly generated token for the request to
    /// ensure idempotency.
    client_token: ?[]const u8 = null,

    /// The name of the schedule group associated with this schedule. If you omit
    /// this, the default schedule group is used.
    group_name: ?[]const u8 = null,

    /// The name of the schedule to delete.
    name: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .group_name = "GroupName",
        .name = "Name",
    };
};

pub const DeleteScheduleOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteScheduleInput, options: CallOptions) !DeleteScheduleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "scheduler", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteScheduleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("scheduler", "Scheduler", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/schedules/");
    try path_buf.appendSlice(allocator, input.name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.client_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clientToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.group_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "groupName=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteScheduleOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteScheduleOutput = .{};

    return result;
}
