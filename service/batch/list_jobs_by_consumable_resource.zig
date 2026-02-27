const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const KeyValuesPair = @import("key_values_pair.zig").KeyValuesPair;
const ListJobsByConsumableResourceSummary = @import("list_jobs_by_consumable_resource_summary.zig").ListJobsByConsumableResourceSummary;

pub const ListJobsByConsumableResourceInput = struct {
    /// The name or ARN of the consumable resource.
    consumable_resource: []const u8,

    /// The filters to apply to the job list query. If used, only those jobs
    /// requiring the specified
    /// consumable resource (`consumableResource`) and that match the value of the
    /// filters
    /// are listed. The filter names and values can be:
    ///
    /// * name: `JOB_STATUS`
    ///
    /// values: `SUBMITTED | PENDING | RUNNABLE | STARTING | RUNNING | SUCCEEDED |
    /// FAILED`
    ///
    /// * name: `JOB_NAME `
    ///
    /// The values are case-insensitive matches for the job name. If a filter value
    /// ends
    /// with an asterisk (*), it matches any job name that begins with the string
    /// before
    /// the '*'.
    filters: ?[]const KeyValuesPair = null,

    /// The maximum number of results returned by `ListJobsByConsumableResource` in
    /// paginated
    /// output. When this parameter is used, `ListJobsByConsumableResource` only
    /// returns
    /// `maxResults` results in a single page and a `nextToken` response
    /// element. The remaining results of the initial request can be seen by sending
    /// another
    /// `ListJobsByConsumableResource` request with the returned `nextToken` value.
    /// This value can be between 1 and 100. If this parameter isn't
    /// used, then `ListJobsByConsumableResource` returns up to 100 results
    /// and a `nextToken` value if applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated
    /// `ListJobsByConsumableResource` request where `maxResults` was used and the
    /// results exceeded the value of that parameter. Pagination continues from the
    /// end of the previous
    /// results that returned the `nextToken` value. This value is `null` when
    /// there are no more results to return.
    ///
    /// Treat this token as an opaque identifier that's only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .consumable_resource = "consumableResource",
        .filters = "filters",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListJobsByConsumableResourceOutput = struct {
    /// The list of jobs that require the specified consumable resources.
    jobs: ?[]const ListJobsByConsumableResourceSummary = null,

    /// The `nextToken` value to include in a future `ListJobsByConsumableResource`
    /// request. When the results of a `ListJobsByConsumableResource` request exceed
    /// `maxResults`, this value can be used to retrieve the next page of results.
    /// This
    /// value is `null` when there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .jobs = "jobs",
        .next_token = "nextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListJobsByConsumableResourceInput, options: Options) !ListJobsByConsumableResourceOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ListJobsByConsumableResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("batch", "Batch", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v1/listjobsbyconsumableresource";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"consumableResource\":");
    try aws.json.writeValue(@TypeOf(input.consumable_resource), input.consumable_resource, alloc, &body_buf);
    has_prev = true;
    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ListJobsByConsumableResourceOutput {
    var result: ListJobsByConsumableResourceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListJobsByConsumableResourceOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
