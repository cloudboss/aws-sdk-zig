const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortDirection = @import("sort_direction.zig").SortDirection;
const BasicDeviceObject = @import("basic_device_object.zig").BasicDeviceObject;

pub const ListDevicesForUserInput = struct {
    /// The maximum number of devices to return in a single page. Valid range is
    /// 1-100. Default is 10.
    max_results: ?i32 = null,

    /// The ID of the Wickr network containing the user.
    network_id: []const u8,

    /// The token for retrieving the next page of results. This is returned from a
    /// previous request when there are more results available.
    next_token: ?[]const u8 = null,

    /// The direction to sort results. Valid values are 'ASC' (ascending) or 'DESC'
    /// (descending). Default is 'DESC'.
    sort_direction: ?SortDirection = null,

    /// The fields to sort devices by. Multiple fields can be specified by
    /// separating them with '+'. Accepted values include 'lastlogin', 'type',
    /// 'suspend', and 'created'.
    sort_fields: ?[]const u8 = null,

    /// The unique identifier of the user whose devices will be listed.
    user_id: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .network_id = "networkId",
        .next_token = "nextToken",
        .sort_direction = "sortDirection",
        .sort_fields = "sortFields",
        .user_id = "userId",
    };
};

pub const ListDevicesForUserOutput = struct {
    /// A list of device objects associated with the user within the current page.
    devices: ?[]const BasicDeviceObject = null,

    /// The token to use for retrieving the next page of results. If this is not
    /// present, there are no more results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .devices = "devices",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDevicesForUserInput, options: CallOptions) !ListDevicesForUserOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDevicesForUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("admin.wickr", "Wickr", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/networks/");
    try path_buf.appendSlice(allocator, input.network_id);
    try path_buf.appendSlice(allocator, "/users/");
    try path_buf.appendSlice(allocator, input.user_id);
    try path_buf.appendSlice(allocator, "/devices");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
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
    if (input.sort_direction) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "sortDirection=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (input.sort_fields) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "sortFields=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDevicesForUserOutput {
    var result: ListDevicesForUserOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListDevicesForUserOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
