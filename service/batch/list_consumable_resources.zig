const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const KeyValuesPair = @import("key_values_pair.zig").KeyValuesPair;
const ConsumableResourceSummary = @import("consumable_resource_summary.zig").ConsumableResourceSummary;

pub const ListConsumableResourcesInput = struct {
    /// The filters to apply to the consumable resource list query. If used, only
    /// those consumable
    /// resources that match the filter are listed. Filter names and values can be:
    ///
    /// * name: `CONSUMABLE_RESOURCE_NAME `
    ///
    /// values: case-insensitive matches for the consumable resource name. If a
    /// filter
    /// value ends with an asterisk (*), it matches any consumable resource name
    /// that begins
    /// with the string before the '*'.
    filters: ?[]const KeyValuesPair = null,

    /// The maximum number of results returned by `ListConsumableResources` in
    /// paginated
    /// output. When this parameter is used, `ListConsumableResources` only returns
    /// `maxResults` results in a single page and a `nextToken` response
    /// element. The remaining results of the initial request can be seen by sending
    /// another
    /// `ListConsumableResources` request with the returned `nextToken` value.
    /// This value can be between 1 and 100. If this parameter isn't
    /// used, then `ListConsumableResources` returns up to 100 results and
    /// a `nextToken` value if applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated
    /// `ListConsumableResources` request where `maxResults` was used and the
    /// results exceeded the value of that parameter. Pagination continues from the
    /// end of the previous
    /// results that returned the `nextToken` value. This value is `null` when
    /// there are no more results to return.
    ///
    /// Treat this token as an opaque identifier that's only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListConsumableResourcesOutput = struct {
    /// A list of consumable resources that match the request.
    consumable_resources: ?[]const ConsumableResourceSummary = null,

    /// The `nextToken` value to include in a future `ListConsumableResources`
    /// request. When the results of a `ListConsumableResources` request exceed
    /// `maxResults`,
    /// this value can be used to retrieve the next page of results. This value is
    /// `null`
    /// when there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .consumable_resources = "consumableResources",
        .next_token = "nextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListConsumableResourcesInput, options: Options) !ListConsumableResourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "batch");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ListConsumableResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/listconsumableresources";

    var body_buf: std.ArrayList(u8) = .{};
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
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListConsumableResourcesOutput {
    var result: ListConsumableResourcesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListConsumableResourcesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ClientException")) {
        return .{ .arena = arena, .kind = .{ .client_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServerException")) {
        return .{ .arena = arena, .kind = .{ .server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
