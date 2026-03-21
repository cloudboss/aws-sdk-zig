const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ListPrefetchScheduleType = @import("list_prefetch_schedule_type.zig").ListPrefetchScheduleType;
const PrefetchSchedule = @import("prefetch_schedule.zig").PrefetchSchedule;

pub const ListPrefetchSchedulesInput = struct {
    /// The maximum number of prefetch schedules that you want MediaTailor to return
    /// in response to the current request. If there are more than `MaxResults`
    /// prefetch schedules, use the value of `NextToken` in the response to get the
    /// next page of results.
    ///
    /// The default value is 100. MediaTailor uses DynamoDB-based pagination, which
    /// means that a response might contain fewer than `MaxResults` items, including
    /// 0 items, even when more results are available. To retrieve all results, you
    /// must continue making requests using the `NextToken` value from each response
    /// until the response no longer includes a `NextToken` value.
    max_results: ?i32 = null,

    /// Pagination token returned by the list request when results exceed the
    /// maximum allowed. Use the token to fetch the next page of results.
    ///
    /// For the first `ListPrefetchSchedules` request, omit this value. For
    /// subsequent requests, get the value of `NextToken` from the previous response
    /// and specify that value for `NextToken` in the request. Continue making
    /// requests until the response no longer includes a `NextToken` value, which
    /// indicates that all results have been retrieved.
    next_token: ?[]const u8 = null,

    /// Retrieves the prefetch schedule(s) for a specific playback configuration.
    playback_configuration_name: []const u8,

    /// The type of prefetch schedules that you want to list. `SINGLE` indicates
    /// that you want to list the configured single prefetch schedules. `RECURRING`
    /// indicates that you want to list the configured recurring prefetch schedules.
    /// `ALL` indicates that you want to list all configured prefetch schedules.
    schedule_type: ?ListPrefetchScheduleType = null,

    /// An optional filtering parameter whereby MediaTailor filters the prefetch
    /// schedules to include only specific streams.
    stream_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .playback_configuration_name = "PlaybackConfigurationName",
        .schedule_type = "ScheduleType",
        .stream_id = "StreamId",
    };
};

pub const ListPrefetchSchedulesOutput = struct {
    /// Lists the prefetch schedules. An empty `Items` list doesn't mean there
    /// aren't more items to fetch, just that that page was empty.
    items: ?[]const PrefetchSchedule = null,

    /// Pagination token returned by the list request when results exceed the
    /// maximum allowed. Use the token to fetch the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "Items",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListPrefetchSchedulesInput, options: CallOptions) !ListPrefetchSchedulesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mediatailor");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListPrefetchSchedulesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.mediatailor", "MediaTailor", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/prefetchSchedule/");
    try path_buf.appendSlice(allocator, input.playback_configuration_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.schedule_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ScheduleType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stream_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StreamId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListPrefetchSchedulesOutput {
    var result: ListPrefetchSchedulesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListPrefetchSchedulesOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
