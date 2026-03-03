const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const FrameMetric = @import("frame_metric.zig").FrameMetric;
const AggregationPeriod = @import("aggregation_period.zig").AggregationPeriod;
const TimestampStructure = @import("timestamp_structure.zig").TimestampStructure;
const FrameMetricDatum = @import("frame_metric_datum.zig").FrameMetricDatum;

pub const BatchGetFrameMetricDataInput = struct {
    /// The end time of the time period for the returned time series values.
    /// This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    end_time: ?i64 = null,

    /// The details of the metrics that are used to request a time series of values.
    /// The metric includes
    /// the name of the frame, the aggregation type to calculate the metric value
    /// for the
    /// frame, and the thread states to use to get the count for the metric value of
    /// the frame.
    frame_metrics: ?[]const FrameMetric = null,

    /// The duration of the frame metrics used to return the time series values.
    /// Specify using the ISO 8601 format. The maximum period duration
    /// is one day (`PT24H` or `P1D`).
    period: ?[]const u8 = null,

    /// The name of the profiling group associated with the
    /// the frame metrics used to return the time series values.
    profiling_group_name: []const u8,

    /// The start time of the time period for the frame metrics used to return the
    /// time series values.
    /// This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    start_time: ?i64 = null,

    /// The requested resolution of time steps for the returned time series of
    /// values.
    /// If the requested target resolution is not available due to data not being
    /// retained we provide a best effort
    /// result by falling back to the most granular available resolution after the
    /// target resolution.
    /// There are 3 valid values.
    ///
    /// * `P1D` — 1 day
    ///
    /// * `PT1H` — 1 hour
    ///
    /// * `PT5M` — 5 minutes
    target_resolution: ?AggregationPeriod = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .frame_metrics = "frameMetrics",
        .period = "period",
        .profiling_group_name = "profilingGroupName",
        .start_time = "startTime",
        .target_resolution = "targetResolution",
    };
};

pub const BatchGetFrameMetricDataOutput = struct {
    /// The end time of the time period for the returned time series values.
    /// This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    end_time: i64,

    /// List of instances, or time steps, in the time series. For example, if the
    /// `period` is one day (`PT24H)`), and the `resolution`
    /// is five minutes (`PT5M`), then there are 288 `endTimes` in the
    /// list that are each five minutes appart.
    end_times: ?[]const TimestampStructure = null,

    /// Details of the metrics to request a time series of values. The metric
    /// includes
    /// the name of the frame, the aggregation type to calculate the metric value
    /// for the frame,
    /// and the thread states to use to get the count for the metric value of the
    /// frame.
    frame_metric_data: ?[]const FrameMetricDatum = null,

    /// Resolution or granularity of the profile data used to generate the time
    /// series.
    /// This is the value used to jump through time steps in a time series. There
    /// are 3 valid values.
    ///
    /// * `P1D` — 1 day
    ///
    /// * `PT1H` — 1 hour
    ///
    /// * `PT5M` — 5 minutes
    resolution: AggregationPeriod,

    /// The start time of the time period for the returned time series values.
    /// This is specified
    /// using the ISO 8601 format. For example, 2020-06-01T13:15:02.001Z represents
    /// 1
    /// millisecond past June 1, 2020 1:15:02 PM UTC.
    start_time: i64,

    /// List of instances which remained unprocessed. This will create a missing
    /// time step in the list of end times.
    unprocessed_end_times: ?[]const aws.map.MapEntry([]const TimestampStructure) = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .end_times = "endTimes",
        .frame_metric_data = "frameMetricData",
        .resolution = "resolution",
        .start_time = "startTime",
        .unprocessed_end_times = "unprocessedEndTimes",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetFrameMetricDataInput, options: Options) !BatchGetFrameMetricDataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetFrameMetricDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("codeguruprofiler", "CodeGuruProfiler", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/profilingGroups/");
    try path_buf.appendSlice(allocator, input.profiling_group_name);
    try path_buf.appendSlice(allocator, "/frames/-/metrics");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
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
    if (input.period) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "period=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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
    if (input.target_resolution) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "targetResolution=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, @tagName(v));
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.frame_metrics) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"frameMetrics\":");
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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetFrameMetricDataOutput {
    var result: BatchGetFrameMetricDataOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetFrameMetricDataOutput, body, allocator);
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
