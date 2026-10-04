const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Dimension = @import("dimension.zig").Dimension;
const Statistic = @import("statistic.zig").Statistic;
const StandardUnit = @import("standard_unit.zig").StandardUnit;
const MetricAlarm = @import("metric_alarm.zig").MetricAlarm;
const serde = @import("serde.zig");

pub const DescribeAlarmsForMetricInput = struct {
    /// The dimensions associated with the metric. If the metric has any associated
    /// dimensions, you must specify them in order for the call to succeed.
    dimensions: ?[]const Dimension = null,

    /// The percentile statistic for the metric. Specify a value between p0.0 and
    /// p100.
    extended_statistic: ?[]const u8 = null,

    /// The name of the metric.
    metric_name: []const u8,

    /// The namespace of the metric.
    namespace: []const u8,

    /// The period, in seconds, over which the statistic is applied.
    period: ?i32 = null,

    /// The statistic for the metric, other than percentiles. For percentile
    /// statistics,
    /// use `ExtendedStatistics`.
    statistic: ?Statistic = null,

    /// The unit for the metric.
    unit: ?StandardUnit = null,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .extended_statistic = "ExtendedStatistic",
        .metric_name = "MetricName",
        .namespace = "Namespace",
        .period = "Period",
        .statistic = "Statistic",
        .unit = "Unit",
    };
};

pub const DescribeAlarmsForMetricOutput = struct {
    /// The information for each alarm with the specified metric.
    metric_alarms: ?[]const MetricAlarm = null,

    pub const json_field_names = .{
        .metric_alarms = "MetricAlarms",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeAlarmsForMetricInput, options: CallOptions) !DescribeAlarmsForMetricOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "monitoring", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeAlarmsForMetricInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=DescribeAlarmsForMetric&Version=2010-08-01");
    if (input.dimensions) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Dimensions.member.{d}.Name=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.name);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Dimensions.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.value);
            }
        }
    }
    if (input.extended_statistic) |v| {
        try body_buf.appendSlice(allocator, "&ExtendedStatistic=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&MetricName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.metric_name);
    try body_buf.appendSlice(allocator, "&Namespace=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.namespace);
    if (input.period) |v| {
        try body_buf.appendSlice(allocator, "&Period=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.statistic) |v| {
        try body_buf.appendSlice(allocator, "&Statistic=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.unit) |v| {
        try body_buf.appendSlice(allocator, "&Unit=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeAlarmsForMetricOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "DescribeAlarmsForMetricResult")) break;
            },
            else => {},
        }
    }

    var result: DescribeAlarmsForMetricOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "MetricAlarms")) {
                    result.metric_alarms = try serde.deserializeMetricAlarms(allocator, &reader, "member");
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
