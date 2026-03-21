const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const LabelOptions = @import("label_options.zig").LabelOptions;
const MetricDataQuery = @import("metric_data_query.zig").MetricDataQuery;
const ScanBy = @import("scan_by.zig").ScanBy;
const MessageData = @import("message_data.zig").MessageData;
const MetricDataResult = @import("metric_data_result.zig").MetricDataResult;
const serde = @import("serde.zig");

pub const GetMetricDataInput = struct {
    /// The time stamp indicating the latest data to be returned.
    ///
    /// The value specified is exclusive; results include data points up to the
    /// specified
    /// time stamp.
    ///
    /// For better performance, specify `StartTime` and `EndTime` values
    /// that align with the value of the metric's `Period` and sync up with the
    /// beginning and end of an hour. For example, if the `Period` of a metric is 5
    /// minutes, specifying 12:05 or 12:30 as `EndTime` can get a faster response
    /// from CloudWatch than setting 12:07 or 12:29 as the `EndTime`.
    end_time: i64,

    /// This structure includes the `Timezone` parameter, which you can use to
    /// specify your time zone so that the labels of returned data display the
    /// correct time for
    /// your time zone.
    label_options: ?LabelOptions = null,

    /// The maximum number of data points the request should return before
    /// paginating. If you
    /// omit this, the default of 100,800 is used.
    max_datapoints: ?i32 = null,

    /// The metric queries to be returned. A single `GetMetricData` call can
    /// include as many as 500 `MetricDataQuery` structures. Each of these
    /// structures
    /// can specify either a metric to retrieve, a Metrics Insights query, or a math
    /// expression
    /// to perform on retrieved data.
    metric_data_queries: []const MetricDataQuery,

    /// Include this value, if it was returned by the previous `GetMetricData`
    /// operation, to get the next set of data points.
    next_token: ?[]const u8 = null,

    /// The order in which data points should be returned. `TimestampDescending`
    /// returns the newest data first and paginates when the `MaxDatapoints` limit
    /// is
    /// reached. `TimestampAscending` returns the oldest data first and paginates
    /// when the `MaxDatapoints` limit is reached.
    ///
    /// If you omit this parameter, the default of `TimestampDescending` is
    /// used.
    scan_by: ?ScanBy = null,

    /// The time stamp indicating the earliest data to be returned.
    ///
    /// The value specified is inclusive; results include data points with the
    /// specified
    /// time stamp.
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
    ///
    /// For better performance, specify `StartTime` and `EndTime` values
    /// that align with the value of the metric's `Period` and sync up with the
    /// beginning and end of an hour. For example, if the `Period` of a metric is 5
    /// minutes, specifying 12:05 or 12:30 as `StartTime` can get a faster response
    /// from CloudWatch than setting 12:07 or 12:29 as the `StartTime`.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .label_options = "LabelOptions",
        .max_datapoints = "MaxDatapoints",
        .metric_data_queries = "MetricDataQueries",
        .next_token = "NextToken",
        .scan_by = "ScanBy",
        .start_time = "StartTime",
    };
};

pub const GetMetricDataOutput = struct {
    /// Contains a message about this `GetMetricData` operation, if the operation
    /// results in such a message. An example of a message that might be returned is
    /// `Maximum number of allowed metrics exceeded`. If there is a message, as
    /// much of the operation as possible is still executed.
    ///
    /// A message appears here only if it is related to the global `GetMetricData`
    /// operation. Any message about a specific metric returned by the operation
    /// appears in the
    /// `MetricDataResult` object returned for that metric.
    messages: ?[]const MessageData = null,

    /// The metrics that are returned, including the metric name, namespace, and
    /// dimensions.
    metric_data_results: ?[]const MetricDataResult = null,

    /// A token that marks the next batch of returned results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .messages = "Messages",
        .metric_data_results = "MetricDataResults",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMetricDataInput, options: CallOptions) !GetMetricDataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "monitoring");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMetricDataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=GetMetricData&Version=2010-08-01");
    try body_buf.appendSlice(allocator, "&EndTime=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.end_time}) catch "");
    if (input.label_options) |v| {
        if (v.timezone) |sv| {
            try body_buf.appendSlice(allocator, "&LabelOptions.Timezone=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    if (input.max_datapoints) |v| {
        try body_buf.appendSlice(allocator, "&MaxDatapoints=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    for (input.metric_data_queries, 0..) |item, idx| {
        const n = idx + 1;
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.account_id) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricDataQueries.member.{d}.AccountId=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.expression) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricDataQueries.member.{d}.Expression=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricDataQueries.member.{d}.Id=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item.id);
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.label) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricDataQueries.member.{d}.Label=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
            }
        }
        if (item.metric_stat) |sv_1| {
            if (sv_1.metric.dimensions) |lst_3| {
                for (lst_3, 0..) |item_3, idx_3| {
                    const n_3 = idx_3 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricDataQueries.member.{d}.MetricStat.Metric.Dimensions.member.{d}.Name=", .{n, n_3}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.name);
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricDataQueries.member.{d}.MetricStat.Metric.Dimensions.member.{d}.Value=", .{n, n_3}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.value);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (sv_1.metric.metric_name) |fv_3| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricDataQueries.member.{d}.MetricStat.Metric.MetricName=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (sv_1.metric.namespace) |fv_3| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricDataQueries.member.{d}.MetricStat.Metric.Namespace=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricDataQueries.member.{d}.MetricStat.Period=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv_1.period}) catch "");
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricDataQueries.member.{d}.MetricStat.Stat=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.stat);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (sv_1.unit) |fv_2| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricDataQueries.member.{d}.MetricStat.Unit=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                }
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.period) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricDataQueries.member.{d}.Period=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
            }
        }
        {
            var prefix_buf: [256]u8 = undefined;
            if (item.return_data) |fv_1| {
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricDataQueries.member.{d}.ReturnData=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
            }
        }
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(allocator, "&NextToken=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.scan_by) |v| {
        try body_buf.appendSlice(allocator, "&ScanBy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    try body_buf.appendSlice(allocator, "&StartTime=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.start_time}) catch "");

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMetricDataOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetMetricDataResult")) break;
            },
            else => {},
        }
    }

    var result: GetMetricDataOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Messages")) {
                    result.messages = try serde.deserializeMetricDataResultMessages(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "MetricDataResults")) {
                    result.metric_data_results = try serde.deserializeMetricDataResults(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "NextToken")) {
                    result.next_token = try allocator.dupe(u8, try reader.readElementText());
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestId") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
