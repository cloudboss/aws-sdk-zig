const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Group = @import("group.zig").Group;
const ServerCriteria = @import("server_criteria.zig").ServerCriteria;
const SortOrder = @import("sort_order.zig").SortOrder;
const ServerDetail = @import("server_detail.zig").ServerDetail;

pub const ListServersInput = struct {
    /// Specifies the filter value, which is based on the type of server criteria.
    /// For example,
    /// if `serverCriteria` is `OS_NAME`, and the `filterValue` is
    /// equal to `WindowsServer`, then `ListServers` returns all of the servers
    /// matching the OS name `WindowsServer`.
    filter_value: ?[]const u8 = null,

    /// Specifies the group ID to filter on.
    group_id_filter: ?[]const Group = null,

    /// The maximum number of items to include in the response. The maximum value is
    /// 100.
    max_results: ?i32 = null,

    /// The token from a previous call that you use to retrieve the next set of
    /// results. For example,
    /// if a previous call to this action returned 100 items, but you set
    /// `maxResults` to 10. You'll receive a set of 10 results along
    /// with a token. You then use the returned token to retrieve the next set of
    /// 10.
    next_token: ?[]const u8 = null,

    /// Criteria for filtering servers.
    server_criteria: ?ServerCriteria = null,

    /// Specifies whether to sort by ascending (`ASC`) or descending
    /// (`DESC`) order.
    sort: ?SortOrder = null,

    pub const json_field_names = .{
        .filter_value = "filterValue",
        .group_id_filter = "groupIdFilter",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .server_criteria = "serverCriteria",
        .sort = "sort",
    };
};

pub const ListServersOutput = struct {
    /// The token you use to retrieve the next set of results, or null if there are
    /// no more results.
    next_token: ?[]const u8 = null,

    /// The list of servers with detailed information about each server.
    server_infos: ?[]const ServerDetail = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .server_infos = "serverInfos",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServersInput, options: CallOptions) !ListServersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "awsmigrationhubstrategyrecommendation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListServersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("migrationhub-strategy", "MigrationHubStrategy", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-servers";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filter_value) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filterValue\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.group_id_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"groupIdFilter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.server_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"serverCriteria\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sort\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListServersOutput {
    const result: ListServersOutput = try aws.json.parseJsonObject(
        ListServersOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
