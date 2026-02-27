const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Dimension = @import("dimension.zig").Dimension;
const Statistic = @import("statistic.zig").Statistic;
const StandardUnit = @import("standard_unit.zig").StandardUnit;
const Datapoint = @import("datapoint.zig").Datapoint;
const serde = @import("serde.zig");

pub const GetMetricStatisticsInput = struct {
    /// The dimensions. If the metric contains multiple dimensions, you must include
    /// a
    /// value for each dimension. CloudWatch treats each unique combination of
    /// dimensions as a
    /// separate metric. If a specific combination of dimensions was not published,
    /// you can't
    /// retrieve statistics for it. You must specify the same dimensions that were
    /// used when the
    /// metrics were created. For an example, see [Dimension
    /// Combinations](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/cloudwatch_concepts.html#dimension-combinations) in the *Amazon CloudWatch User
    /// Guide*. For more information about specifying dimensions, see [Publishing
    /// Metrics](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/publishingMetrics.html) in the *Amazon CloudWatch User
    /// Guide*.
    dimensions: ?[]const Dimension = null,

    /// The time stamp that determines the last data point to return.
    ///
    /// The value specified is exclusive; results include data points up to the
    /// specified
    /// time stamp. In a raw HTTP query, the time stamp must be in ISO 8601 UTC
    /// format (for
    /// example, 2016-10-10T23:00:00Z).
    end_time: i64,

    /// The percentile statistics. Specify values between p0.0 and p100. When
    /// calling
    /// `GetMetricStatistics`, you must specify either `Statistics` or
    /// `ExtendedStatistics`, but not both. Percentile statistics are not
    /// available for metrics when any of the metric values are negative numbers.
    extended_statistics: ?[]const []const u8 = null,

    /// The name of the metric, with or without spaces.
    metric_name: []const u8,

    /// The namespace of the metric, with or without spaces.
    namespace: []const u8,

    /// The granularity, in seconds, of the returned data points. For metrics with
    /// regular
    /// resolution, a period can be as short as one minute (60 seconds) and must be
    /// a multiple
    /// of 60. For high-resolution metrics that are collected at intervals of less
    /// than one
    /// minute, the period can be 1, 5, 10, 20, 30, 60, or any multiple of 60.
    /// High-resolution
    /// metrics are those metrics stored by a `PutMetricData` call that includes a
    /// `StorageResolution` of 1 second.
    ///
    /// If the `StartTime` parameter specifies a time stamp that is greater than
    /// 3 hours ago, you must specify the period as follows or no data points in
    /// that time range
    /// is returned:
    ///
    /// * Start time between 3 hours and 15 days ago - Use a multiple of 60 seconds
    /// (1 minute).
    ///
    /// * Start time between 15 and 63 days ago - Use a multiple of 300 seconds (5
    /// minutes).
    ///
    /// * Start time greater than 63 days ago - Use a multiple of 3600 seconds (1
    /// hour).
    period: i32,

    /// The time stamp that determines the first data point to return. Start times
    /// are
    /// evaluated relative to the time that CloudWatch receives the request.
    ///
    /// The value specified is inclusive; results include data points with the
    /// specified
    /// time stamp. In a raw HTTP query, the time stamp must be in ISO 8601 UTC
    /// format (for
    /// example, 2016-10-03T23:00:00Z).
    ///
    /// CloudWatch rounds the specified time stamp as follows:
    ///
    /// * Start time less than 15 days ago - Round down to the nearest whole minute.
    /// For example, 12:32:34 is rounded down to 12:32:00.
    ///
    /// * Start time between 15 and 63 days ago - Round down to the nearest 5-minute
    /// clock interval. For example, 12:32:34 is rounded down to 12:30:00.
    ///
    /// * Start time greater than 63 days ago - Round down to the nearest 1-hour
    /// clock interval. For example, 12:32:34 is rounded down to 12:00:00.
    ///
    /// If you set `Period` to 5, 10, 20, or 30, the start time of your request is
    /// rounded down to the nearest time that corresponds to even 5-, 10-, 20-, or
    /// 30-second
    /// divisions of a minute. For example, if you make a query at (HH:mm:ss)
    /// 01:05:23 for the
    /// previous 10-second period, the start time of your request is rounded down
    /// and you
    /// receive data from 01:05:10 to 01:05:20. If you make a query at 15:07:17 for
    /// the previous
    /// 5 minutes of data, using a period of 5 seconds, you receive data timestamped
    /// between
    /// 15:02:15 and 15:07:15.
    start_time: i64,

    /// The metric statistics, other than percentile. For percentile statistics, use
    /// `ExtendedStatistics`. When calling `GetMetricStatistics`, you
    /// must specify either `Statistics` or `ExtendedStatistics`, but not
    /// both.
    statistics: ?[]const Statistic = null,

    /// The unit for a given metric. If you omit `Unit`, all data that was
    /// collected with any unit is returned, along with the corresponding units that
    /// were
    /// specified when the data was reported to CloudWatch. If you specify a unit,
    /// the operation
    /// returns only data that was collected with that unit specified. If you
    /// specify a unit
    /// that does not match the data collected, the results of the operation are
    /// null.
    /// CloudWatch does not perform unit conversions.
    unit: ?StandardUnit = null,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .end_time = "EndTime",
        .extended_statistics = "ExtendedStatistics",
        .metric_name = "MetricName",
        .namespace = "Namespace",
        .period = "Period",
        .start_time = "StartTime",
        .statistics = "Statistics",
        .unit = "Unit",
    };
};

pub const GetMetricStatisticsOutput = struct {
    /// The data points for the specified metric.
    datapoints: ?[]const Datapoint = null,

    /// A label for the specified metric.
    label: ?[]const u8 = null,

    pub const json_field_names = .{
        .datapoints = "Datapoints",
        .label = "Label",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMetricStatisticsInput, options: Options) !GetMetricStatisticsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudwatch");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetMetricStatisticsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudwatch", "CloudWatch", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetMetricStatistics&Version=2010-08-01");
    if (input.dimensions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Dimensions.member.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item.name);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Dimensions.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(alloc, field_prefix);
                try aws.url.appendUrlEncoded(alloc, &body_buf, item.value);
            }
        }
    }
    try body_buf.appendSlice(alloc, "&EndTime=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.end_time}) catch "");
    if (input.extended_statistics) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExtendedStatistics.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    try body_buf.appendSlice(alloc, "&MetricName=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.metric_name);
    try body_buf.appendSlice(alloc, "&Namespace=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.namespace);
    try body_buf.appendSlice(alloc, "&Period=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.period}) catch "");
    try body_buf.appendSlice(alloc, "&StartTime=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.start_time}) catch "");
    if (input.statistics) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Statistics.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try aws.url.appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.unit) |v| {
        try body_buf.appendSlice(alloc, "&Unit=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetMetricStatisticsOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetMetricStatisticsResult")) break;
            },
            else => {},
        }
    }

    var result: GetMetricStatisticsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Datapoints")) {
                    result.datapoints = try serde.deserializeDatapoints(&reader, alloc, "member");
                } else if (std.mem.eql(u8, e.local, "Label")) {
                    result.label = try alloc.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);

    if (std.mem.eql(u8, error_code, "ConcurrentModificationException")) {
        return .{ .arena = arena, .kind = .{ .concurrent_modification_exception = .{
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
    if (std.mem.eql(u8, error_code, "DashboardInvalidInputError")) {
        return .{ .arena = arena, .kind = .{ .dashboard_invalid_input_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "DashboardNotFoundError")) {
        return .{ .arena = arena, .kind = .{ .dashboard_not_found_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServiceFault")) {
        return .{ .arena = arena, .kind = .{ .internal_service_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidFormatFault")) {
        return .{ .arena = arena, .kind = .{ .invalid_format_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidNextToken")) {
        return .{ .arena = arena, .kind = .{ .invalid_next_token = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterCombinationException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_combination_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterValueException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_value_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededFault")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_fault = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MissingRequiredParameterException")) {
        return .{ .arena = arena, .kind = .{ .missing_required_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFound")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
