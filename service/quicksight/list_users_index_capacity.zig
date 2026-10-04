const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UserIndexCapacityFilter = @import("user_index_capacity_filter.zig").UserIndexCapacityFilter;
const UserIndexCapacitySortBy = @import("user_index_capacity_sort_by.zig").UserIndexCapacitySortBy;
const UserIndexCapacitySortOrder = @import("user_index_capacity_sort_order.zig").UserIndexCapacitySortOrder;
const UserIndexCapacity = @import("user_index_capacity.zig").UserIndexCapacity;

pub const ListUsersIndexCapacityInput = struct {
    /// The ID of the Amazon Web Services account that contains the index capacity
    /// data.
    aws_account_id: []const u8,

    /// Filters to apply. Only one filter is supported per request. The
    /// userNameOrEmail and totalCapacityBytes filters are mutually exclusive.
    filters: ?[]const UserIndexCapacityFilter = null,

    /// The maximum number of results to return per page.
    max_results: ?i32 = null,

    /// The namespace to scope the user search to. Required when the userNameOrEmail
    /// filter is present.
    namespace: ?[]const u8 = null,

    /// The token for the next set of results, received from a previous call.
    next_token: ?[]const u8 = null,

    /// The field to sort results by.
    sort_by: ?UserIndexCapacitySortBy = null,

    /// The sort order for results. Defaults to DESC if not specified.
    sort_order: ?UserIndexCapacitySortOrder = null,

    pub const json_field_names = .{
        .aws_account_id = "awsAccountId",
        .filters = "filters",
        .max_results = "maxResults",
        .namespace = "namespace",
        .next_token = "nextToken",
        .sort_by = "sortBy",
        .sort_order = "sortOrder",
    };
};

pub const ListUsersIndexCapacityOutput = struct {
    /// The token for the next set of results, or null if there are no more results.
    next_token: ?[]const u8 = null,

    /// The Amazon Web Services request ID for this operation.
    request_id: ?[]const u8 = null,

    /// The list of users with their index capacity metrics.
    users: ?[]const UserIndexCapacity = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .request_id = "requestId",
        .users = "users",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListUsersIndexCapacityInput, options: CallOptions) !ListUsersIndexCapacityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListUsersIndexCapacityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/quick-index/user-capacity");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.namespace) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"namespace\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortBy\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_order) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortOrder\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListUsersIndexCapacityOutput {
    const result: ListUsersIndexCapacityOutput = try aws.json.parseJsonObject(
        ListUsersIndexCapacityOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
