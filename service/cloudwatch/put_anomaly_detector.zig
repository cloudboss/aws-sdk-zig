const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnomalyDetectorConfiguration = @import("anomaly_detector_configuration.zig").AnomalyDetectorConfiguration;
const Dimension = @import("dimension.zig").Dimension;
const MetricCharacteristics = @import("metric_characteristics.zig").MetricCharacteristics;
const MetricMathAnomalyDetector = @import("metric_math_anomaly_detector.zig").MetricMathAnomalyDetector;
const SingleMetricAnomalyDetector = @import("single_metric_anomaly_detector.zig").SingleMetricAnomalyDetector;
const serde = @import("serde.zig");

pub const PutAnomalyDetectorInput = struct {
    /// The configuration specifies details about how the anomaly detection model is
    /// to be
    /// trained, including time ranges to exclude when training and updating the
    /// model. You can
    /// specify as many as 10 time ranges.
    ///
    /// The configuration can also include the time zone to use for the metric.
    configuration: ?AnomalyDetectorConfiguration = null,

    /// The metric dimensions to create the anomaly detection model for.
    dimensions: ?[]const Dimension = null,

    /// Use this object to include parameters to provide information about your
    /// metric to
    /// CloudWatch to help it build more accurate anomaly detection models.
    /// Currently, it includes the `PeriodicSpikes` parameter.
    metric_characteristics: ?MetricCharacteristics = null,

    /// The metric math anomaly detector to be created.
    ///
    /// When using `MetricMathAnomalyDetector`, you cannot include the following
    /// parameters in the same operation:
    ///
    /// * `Dimensions`
    ///
    /// * `MetricName`
    ///
    /// * `Namespace`
    ///
    /// * `Stat`
    ///
    /// * the `SingleMetricAnomalyDetector` parameters of
    /// `PutAnomalyDetectorInput`
    ///
    /// Instead, specify the metric math anomaly detector attributes as part of the
    /// property
    /// `MetricMathAnomalyDetector`.
    metric_math_anomaly_detector: ?MetricMathAnomalyDetector = null,

    /// The name of the metric to create the anomaly detection model for.
    metric_name: ?[]const u8 = null,

    /// The namespace of the metric to create the anomaly detection model for.
    namespace: ?[]const u8 = null,

    /// A single metric anomaly detector to be created.
    ///
    /// When using `SingleMetricAnomalyDetector`, you cannot include the following
    /// parameters in the same operation:
    ///
    /// * `Dimensions`
    ///
    /// * `MetricName`
    ///
    /// * `Namespace`
    ///
    /// * `Stat`
    ///
    /// * the `MetricMathAnomalyDetector` parameters of
    /// `PutAnomalyDetectorInput`
    ///
    /// Instead, specify the single metric anomaly detector attributes as part of
    /// the property
    /// `SingleMetricAnomalyDetector`.
    single_metric_anomaly_detector: ?SingleMetricAnomalyDetector = null,

    /// The statistic to use for the metric and the anomaly detection model.
    stat: ?[]const u8 = null,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .dimensions = "Dimensions",
        .metric_characteristics = "MetricCharacteristics",
        .metric_math_anomaly_detector = "MetricMathAnomalyDetector",
        .metric_name = "MetricName",
        .namespace = "Namespace",
        .single_metric_anomaly_detector = "SingleMetricAnomalyDetector",
        .stat = "Stat",
    };
};

pub const PutAnomalyDetectorOutput = struct {
    /// The unique identifier of the anomaly detector that you created or updated.
    anomaly_detector_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .anomaly_detector_id = "AnomalyDetectorId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAnomalyDetectorInput, options: CallOptions) !PutAnomalyDetectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAnomalyDetectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=PutAnomalyDetector&Version=2010-08-01");
    if (input.configuration) |v| {
        if (v.excluded_time_ranges) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Configuration.ExcludedTimeRanges.member.{d}.EndTime=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{item.end_time}) catch "");
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Configuration.ExcludedTimeRanges.member.{d}.StartTime=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{item.start_time}) catch "");
                }
            }
        }
        if (v.metric_timezone) |sv| {
            try body_buf.appendSlice(allocator, "&Configuration.MetricTimezone=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
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
    if (input.metric_characteristics) |v| {
        if (v.periodic_spikes) |sv| {
            try body_buf.appendSlice(allocator, "&MetricCharacteristics.PeriodicSpikes=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, if (sv) "true" else "false");
        }
    }
    if (input.metric_math_anomaly_detector) |v| {
        if (v.metric_data_queries) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (item.account_id) |fv_1| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.AccountId=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (item.expression) |fv_1| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.Expression=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.Id=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item.id);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (item.label) |fv_1| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.Label=", .{n}) catch continue;
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
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.MetricStat.Metric.Dimensions.member.{d}.Name=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.name);
                            }
                            {
                                var prefix_buf: [256]u8 = undefined;
                                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.MetricStat.Metric.Dimensions.member.{d}.Value=", .{n, n_3}) catch continue;
                                try body_buf.appendSlice(allocator, field_prefix);
                                try aws.url.appendUrlEncoded(allocator, &body_buf, item_3.value);
                            }
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_1.metric.metric_name) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.MetricStat.Metric.MetricName=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_1.metric.namespace) |fv_3| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.MetricStat.Metric.Namespace=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.MetricStat.Period=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{sv_1.period}) catch "");
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.MetricStat.Stat=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, sv_1.stat);
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        if (sv_1.unit) |fv_2| {
                            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.MetricStat.Unit=", .{n}) catch continue;
                            try body_buf.appendSlice(allocator, field_prefix);
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (item.period) |fv_1| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.Period=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    if (item.return_data) |fv_1| {
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.ReturnData=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, if (fv_1) "true" else "false");
                    }
                }
            }
        }
    }
    if (input.metric_name) |v| {
        try body_buf.appendSlice(allocator, "&MetricName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.namespace) |v| {
        try body_buf.appendSlice(allocator, "&Namespace=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.single_metric_anomaly_detector) |v| {
        if (v.account_id) |sv| {
            try body_buf.appendSlice(allocator, "&SingleMetricAnomalyDetector.AccountId=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.dimensions) |list_d0| {
            for (list_d0, 0..) |item, idx| {
                const n = idx + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SingleMetricAnomalyDetector.Dimensions.member.{d}.Name=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item.name);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&SingleMetricAnomalyDetector.Dimensions.member.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item.value);
                }
            }
        }
        if (v.metric_name) |sv| {
            try body_buf.appendSlice(allocator, "&SingleMetricAnomalyDetector.MetricName=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.namespace) |sv| {
            try body_buf.appendSlice(allocator, "&SingleMetricAnomalyDetector.Namespace=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
        if (v.stat) |sv| {
            try body_buf.appendSlice(allocator, "&SingleMetricAnomalyDetector.Stat=");
            try aws.url.appendUrlEncoded(allocator, &body_buf, sv);
        }
    }
    if (input.stat) |v| {
        try body_buf.appendSlice(allocator, "&Stat=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAnomalyDetectorOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PutAnomalyDetectorResult")) break;
            },
            else => {},
        }
    }

    var result: PutAnomalyDetectorOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AnomalyDetectorId")) {
                    result.anomaly_detector_id = try allocator.dupe(u8, try reader.readElementText());
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
