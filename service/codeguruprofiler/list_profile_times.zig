const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const OrderBy = @import("order_by.zig").OrderBy;
const AggregationPeriod = @import("aggregation_period.zig").AggregationPeriod;
const ProfileTime = @import("profile_time.zig").ProfileTime;

pub const ListProfileTimesInput = struct {
    /// The end time of the time range from which to list the profiles.
    end_time: i64,

    /// The maximum number of profile time results returned by `ListProfileTimes`
    /// in paginated output. When this parameter is used, `ListProfileTimes` only
    /// returns
    /// `maxResults` results in a single page with a `nextToken` response
    /// element. The remaining results of the initial request
    /// can be seen by sending another `ListProfileTimes` request with the returned
    /// `nextToken` value.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated
    /// `ListProfileTimes` request where `maxResults` was used and the results
    /// exceeded the value of that parameter. Pagination continues from the end of
    /// the previous results
    /// that returned the `nextToken` value.
    ///
    /// This token should be treated as an opaque identifier that is only used to
    /// retrieve
    /// the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    /// The order (ascending or descending by start time of the profile) to
    /// use when listing profiles. Defaults to `TIMESTAMP_DESCENDING`.
    order_by: ?OrderBy = null,

    /// The aggregation period. This specifies the period during which an
    /// aggregation profile
    /// collects posted agent profiles for a profiling group. There are 3 valid
    /// values.
    ///
    /// * `P1D` — 1 day
    ///
    /// * `PT1H` — 1 hour
    ///
    /// * `PT5M` — 5 minutes
    period: AggregationPeriod,

    /// The name of the profiling group.
    profiling_group_name: []const u8,

    /// The start time of the time range from which to list the profiles.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "endTime",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .order_by = "orderBy",
        .period = "period",
        .profiling_group_name = "profilingGroupName",
        .start_time = "startTime",
    };
};

pub const ListProfileTimesOutput = struct {
    /// The `nextToken` value to include in a future `ListProfileTimes` request.
    /// When the results of a `ListProfileTimes` request exceed `maxResults`, this
    /// value can be used to retrieve the next page of results. This value is `null`
    /// when there are no more
    /// results to return.
    next_token: ?[]const u8 = null,

    /// The list of start times of the available profiles for the aggregation
    /// period in the specified time range.
    profile_times: ?[]const ProfileTime = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .profile_times = "profileTimes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListProfileTimesInput, options: CallOptions) !ListProfileTimesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "codeguruprofiler");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListProfileTimesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguruprofiler", "CodeGuruProfiler", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/profilingGroups/");
    try path_buf.appendSlice(allocator, input.profiling_group_name);
    try path_buf.appendSlice(allocator, "/profileTimes");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "endTime=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.end_time}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
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
    if (input.order_by) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "orderBy=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "period=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, @tagName(input.period));
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "startTime=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.start_time}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListProfileTimesOutput {
    var result: ListProfileTimesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListProfileTimesOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
