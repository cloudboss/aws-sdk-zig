const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const InsightRuleContributor = @import("insight_rule_contributor.zig").InsightRuleContributor;
const InsightRuleMetricDatapoint = @import("insight_rule_metric_datapoint.zig").InsightRuleMetricDatapoint;
const serde = @import("serde.zig");

pub const GetInsightRuleReportInput = struct {
    /// The end time of the data to use in the report. When used in a raw HTTP Query
    /// API, it
    /// is formatted as `yyyy-MM-dd'T'HH:mm:ss`. For example,
    /// `2019-07-01T23:59:59`.
    end_time: i64,

    /// The maximum number of contributors to include in the report. The range is 1
    /// to 100. If
    /// you omit this, the default of 10 is used.
    max_contributor_count: ?i32 = null,

    /// Specifies which metrics to use for aggregation of contributor values for the
    /// report.
    /// You can specify one or more of the following metrics:
    ///
    /// * `UniqueContributors` -- the number of unique contributors for each
    /// data point.
    ///
    /// * `MaxContributorValue` -- the value of the top contributor for each
    /// data point. The identity of the contributor might change for each data point
    /// in
    /// the graph.
    ///
    /// If this rule aggregates by COUNT, the top contributor for each data point is
    /// the contributor with the most occurrences in that period. If the rule
    /// aggregates
    /// by SUM, the top contributor is the contributor with the highest sum in the
    /// log
    /// field specified by the rule's `Value`, during that period.
    ///
    /// * `SampleCount` -- the number of data points matched by the
    /// rule.
    ///
    /// * `Sum` -- the sum of the values from all contributors during the
    /// time period represented by that data point.
    ///
    /// * `Minimum` -- the minimum value from a single observation during the
    /// time period represented by that data point.
    ///
    /// * `Maximum` -- the maximum value from a single observation during the
    /// time period represented by that data point.
    ///
    /// * `Average` -- the average value from all contributors during the
    /// time period represented by that data point.
    metrics: ?[]const []const u8 = null,

    /// Determines what statistic to use to rank the contributors. Valid values are
    /// `Sum` and `Maximum`.
    order_by: ?[]const u8 = null,

    /// The period, in seconds, to use for the statistics in the
    /// `InsightRuleMetricDatapoint` results.
    period: i32,

    /// The name of the rule that you want to see data from.
    rule_name: []const u8,

    /// The start time of the data to use in the report. When used in a raw HTTP
    /// Query API, it
    /// is formatted as `yyyy-MM-dd'T'HH:mm:ss`. For example,
    /// `2019-07-01T23:59:59`.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .max_contributor_count = "MaxContributorCount",
        .metrics = "Metrics",
        .order_by = "OrderBy",
        .period = "Period",
        .rule_name = "RuleName",
        .start_time = "StartTime",
    };
};

pub const GetInsightRuleReportOutput = struct {
    /// The sum of the values from all individual contributors that match the rule.
    aggregate_value: ?f64 = null,

    /// Specifies whether this rule aggregates contributor data by COUNT or SUM.
    aggregation_statistic: ?[]const u8 = null,

    /// An approximate count of the unique contributors found by this rule in this
    /// time
    /// period.
    approximate_unique_count: ?i64 = null,

    /// An array of the unique contributors found by this rule in this time period.
    /// If the
    /// rule contains multiple keys, each combination of values for the keys counts
    /// as a unique
    /// contributor.
    contributors: ?[]const InsightRuleContributor = null,

    /// An array of the strings used as the keys for this rule. The keys are the
    /// dimensions
    /// used to classify contributors. If the rule contains more than one key, then
    /// each unique
    /// combination of values for the keys is counted as a unique contributor.
    key_labels: ?[]const []const u8 = null,

    /// A time series of metric data points that matches the time period in the rule
    /// request.
    metric_datapoints: ?[]const InsightRuleMetricDatapoint = null,

    pub const json_field_names = .{
        .aggregate_value = "AggregateValue",
        .aggregation_statistic = "AggregationStatistic",
        .approximate_unique_count = "ApproximateUniqueCount",
        .contributors = "Contributors",
        .key_labels = "KeyLabels",
        .metric_datapoints = "MetricDatapoints",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInsightRuleReportInput, options: CallOptions) !GetInsightRuleReportOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetInsightRuleReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudwatch", "CloudWatch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=GetInsightRuleReport&Version=2010-08-01");
    try body_buf.appendSlice(allocator, "&EndTime=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.end_time}) catch "");
    if (input.max_contributor_count) |v| {
        try body_buf.appendSlice(allocator, "&MaxContributorCount=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.metrics) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Metrics.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(allocator, field_prefix);
            try aws.url.appendUrlEncoded(allocator, &body_buf, item);
        }
    }
    if (input.order_by) |v| {
        try body_buf.appendSlice(allocator, "&OrderBy=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&Period=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{input.period}) catch "");
    try body_buf.appendSlice(allocator, "&RuleName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.rule_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInsightRuleReportOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetInsightRuleReportResult")) break;
            },
            else => {},
        }
    }

    var result: GetInsightRuleReportOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AggregateValue")) {
                    result.aggregate_value = std.fmt.parseFloat(f64, try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "AggregationStatistic")) {
                    result.aggregation_statistic = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ApproximateUniqueCount")) {
                    result.approximate_unique_count = std.fmt.parseInt(i64, try reader.readElementText(), 10) catch null;
                } else if (std.mem.eql(u8, e.local, "Contributors")) {
                    result.contributors = try serde.deserializeInsightRuleContributors(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "KeyLabels")) {
                    result.key_labels = try serde.deserializeInsightRuleContributorKeyLabels(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "MetricDatapoints")) {
                    result.metric_datapoints = try serde.deserializeInsightRuleMetricDatapoints(allocator, &reader, "member");
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
