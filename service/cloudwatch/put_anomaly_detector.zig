const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAnomalyDetectorInput, options: CallOptions) !PutAnomalyDetectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutAnomalyDetectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudwatch", "CloudWatch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

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
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.AccountId=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (item.account_id) |fv_1| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.Expression=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (item.expression) |fv_1| {
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
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.Label=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (item.label) |fv_1| {
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.MetricStat.Metric.MetricName=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (sv_1.metric.metric_name) |fv_3| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_3);
                        }
                    }
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.MetricStat.Metric.Namespace=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (sv_1.metric.namespace) |fv_3| {
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
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.MetricStat.Unit=", .{n}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        if (sv_1.unit) |fv_2| {
                            try aws.url.appendUrlEncoded(allocator, &body_buf, fv_2.wireName());
                        }
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.Period=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (item.period) |fv_1| {
                        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{fv_1}) catch "");
                    }
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&MetricMathAnomalyDetector.MetricDataQueries.member.{d}.ReturnData=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    if (item.return_data) |fv_1| {
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAnomalyDetectorOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    const result: PutAnomalyDetectorOutput = .{};

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
