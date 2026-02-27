const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const UsageGroupByField = @import("usage_group_by_field.zig").UsageGroupByField;
const Period = @import("period.zig").Period;
const SessionsStatisticsResources = @import("sessions_statistics_resources.zig").SessionsStatisticsResources;
const UsageStatistic = @import("usage_statistic.zig").UsageStatistic;

pub const StartSessionsStatisticsAggregationInput = struct {
    /// The Linux timestamp of the date and time that the statistics end.
    end_time: i64,

    /// The identifier of the farm that contains queues or fleets to return
    /// statistics for.
    farm_id: []const u8,

    /// The field to use to group the statistics.
    group_by: []const UsageGroupByField,

    /// The period to aggregate the statistics.
    period: ?Period = null,

    /// A list of fleet IDs or queue IDs to gather statistics for.
    resource_ids: SessionsStatisticsResources,

    /// The Linux timestamp of the date and time that the statistics start.
    start_time: i64,

    /// One to four statistics to return.
    statistics: []const UsageStatistic,

    /// The timezone to use for the statistics. Use UTC notation such as "UTC+8."
    timezone: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .farm_id = "farmId",
        .group_by = "groupBy",
        .period = "period",
        .resource_ids = "resourceIds",
        .start_time = "startTime",
        .statistics = "statistics",
        .timezone = "timezone",
    };
};

pub const StartSessionsStatisticsAggregationOutput = struct {
    /// A unique identifier for the aggregated statistics. Use this identifier with
    /// the `GetAggregatedStatisticsForSessions` operation to return the statistics.
    aggregation_id: []const u8,

    pub const json_field_names = .{
        .aggregation_id = "aggregationId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSessionsStatisticsAggregationInput, options: Options) !StartSessionsStatisticsAggregationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "deadline");

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

fn serializeRequest(alloc: std.mem.Allocator, input: StartSessionsStatisticsAggregationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/2023-10-12/farms/");
    try path_buf.appendSlice(alloc, input.farm_id);
    try path_buf.appendSlice(alloc, "/sessions-statistics-aggregation");
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"endTime\":");
    try aws.json.writeValue(@TypeOf(input.end_time), input.end_time, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"groupBy\":");
    try aws.json.writeValue(@TypeOf(input.group_by), input.group_by, alloc, &body_buf);
    has_prev = true;
    if (input.period) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"period\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"resourceIds\":");
    try aws.json.writeValue(@TypeOf(input.resource_ids), input.resource_ids, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"startTime\":");
    try aws.json.writeValue(@TypeOf(input.start_time), input.start_time, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"statistics\":");
    try aws.json.writeValue(@TypeOf(input.statistics), input.statistics, alloc, &body_buf);
    has_prev = true;
    if (input.timezone) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"timezone\":");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartSessionsStatisticsAggregationOutput {
    var result: StartSessionsStatisticsAggregationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartSessionsStatisticsAggregationOutput, body, alloc);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
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
