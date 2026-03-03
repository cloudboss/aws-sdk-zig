const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const MetricStreamFilter = @import("metric_stream_filter.zig").MetricStreamFilter;
const MetricStreamOutputFormat = @import("metric_stream_output_format.zig").MetricStreamOutputFormat;
const MetricStreamStatisticsConfiguration = @import("metric_stream_statistics_configuration.zig").MetricStreamStatisticsConfiguration;
const Tag = @import("tag.zig").Tag;
const serde = @import("serde.zig");

pub const PutMetricStreamInput = struct {
    /// If you specify this parameter, the stream sends metrics from all metric
    /// namespaces
    /// except for the namespaces that you specify here.
    ///
    /// You cannot include `ExcludeFilters` and `IncludeFilters` in the
    /// same operation.
    exclude_filters: ?[]const MetricStreamFilter = null,

    /// The ARN of the Amazon Kinesis Data Firehose delivery stream to use for this
    /// metric
    /// stream. This Amazon Kinesis Data Firehose delivery stream must already exist
    /// and must be
    /// in the same account as the metric stream.
    firehose_arn: []const u8,

    /// If you specify this parameter, the stream sends only the metrics from the
    /// metric
    /// namespaces that you specify here.
    ///
    /// You cannot include `IncludeFilters` and `ExcludeFilters` in the
    /// same operation.
    include_filters: ?[]const MetricStreamFilter = null,

    /// If you are creating a metric stream in a monitoring account, specify `true`
    /// to include metrics from source accounts in the metric stream.
    include_linked_accounts_metrics: ?bool = null,

    /// If you are creating a new metric stream, this is the name for the new
    /// stream. The name
    /// must be different than the names of other metric streams in this account and
    /// Region.
    ///
    /// If you are updating a metric stream, specify the name of that stream here.
    ///
    /// Valid characters are A-Z, a-z, 0-9, "-" and "_".
    name: []const u8,

    /// The output format for the stream. Valid values are `json`,
    /// `opentelemetry1.0`, and `opentelemetry0.7`. For more
    /// information about metric stream output formats, see [
    /// Metric streams output
    /// formats](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-metric-streams-formats.html).
    output_format: MetricStreamOutputFormat,

    /// The ARN of an IAM role that this metric stream will use to access Amazon
    /// Kinesis Data
    /// Firehose resources. This IAM role must already exist and must be in the same
    /// account as
    /// the metric stream. This IAM role must include the following permissions:
    ///
    /// * firehose:PutRecord
    ///
    /// * firehose:PutRecordBatch
    role_arn: []const u8,

    /// By default, a metric stream always sends the `MAX`, `MIN`,
    /// `SUM`, and `SAMPLECOUNT` statistics for each metric that is
    /// streamed. You can use this parameter to have the metric stream also send
    /// additional
    /// statistics in the stream. This array can have up to 100 members.
    ///
    /// For each entry in this array, you specify one or more metrics and the list
    /// of
    /// additional statistics to stream for those metrics. The additional statistics
    /// that you
    /// can stream depend on the stream's `OutputFormat`. If the
    /// `OutputFormat` is `json`, you can stream any additional
    /// statistic that is supported by CloudWatch, listed in [
    /// CloudWatch statistics
    /// definitions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Statistics-definitions.html.html). If the `OutputFormat`
    /// is `opentelemetry1.0` or `opentelemetry0.7`, you can stream
    /// percentile statistics such as p95, p99.9, and so on.
    statistics_configurations: ?[]const MetricStreamStatisticsConfiguration = null,

    /// A list of key-value pairs to associate with the metric stream. You can
    /// associate as
    /// many as 50 tags with a metric stream.
    ///
    /// Tags can help you organize and categorize your resources. You can also use
    /// them to
    /// scope user permissions by granting a user permission to access or change
    /// only resources
    /// with certain tag values.
    ///
    /// You can use this parameter only when you are creating a new metric stream.
    /// If you are
    /// using this operation to update an existing metric stream, any tags you
    /// specify in this
    /// parameter are ignored. To change the tags of an existing metric stream, use
    /// [TagResource](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_TagResource.html) or [UntagResource](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_UntagResource.html).
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .exclude_filters = "ExcludeFilters",
        .firehose_arn = "FirehoseArn",
        .include_filters = "IncludeFilters",
        .include_linked_accounts_metrics = "IncludeLinkedAccountsMetrics",
        .name = "Name",
        .output_format = "OutputFormat",
        .role_arn = "RoleArn",
        .statistics_configurations = "StatisticsConfigurations",
        .tags = "Tags",
    };
};

pub const PutMetricStreamOutput = struct {
    /// The ARN of the metric stream.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutMetricStreamInput, options: CallOptions) !PutMetricStreamOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutMetricStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudwatch", "CloudWatch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=PutMetricStream&Version=2010-08-01");
    if (input.exclude_filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.metric_names) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludeFilters.member.{d}.MetricNames.member.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&ExcludeFilters.member.{d}.Namespace=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.namespace) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    try body_buf.appendSlice(allocator, "&FirehoseArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.firehose_arn);
    if (input.include_filters) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            if (item.metric_names) |lst_1| {
                for (lst_1, 0..) |item_1, idx_1| {
                    const n_1 = idx_1 + 1;
                    {
                        var prefix_buf: [256]u8 = undefined;
                        const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IncludeFilters.member.{d}.MetricNames.member.{d}=", .{n, n_1}) catch continue;
                        try body_buf.appendSlice(allocator, field_prefix);
                        try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                    }
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&IncludeFilters.member.{d}.Namespace=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                if (item.namespace) |fv_1| {
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
    }
    if (input.include_linked_accounts_metrics) |v| {
        try body_buf.appendSlice(allocator, "&IncludeLinkedAccountsMetrics=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(allocator, "&Name=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.name);
    try body_buf.appendSlice(allocator, "&OutputFormat=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, @tagName(input.output_format));
    try body_buf.appendSlice(allocator, "&RoleArn=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.role_arn);
    if (input.statistics_configurations) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            for (item.additional_statistics, 0..) |item_1, idx_1| {
                const n_1 = idx_1 + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&StatisticsConfigurations.member.{d}.AdditionalStatistics.member.{d}=", .{n, n_1}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_1);
                }
            }
            for (item.include_metrics, 0..) |item_1, idx_1| {
                const n_1 = idx_1 + 1;
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&StatisticsConfigurations.member.{d}.IncludeMetrics.member.{d}.MetricName=", .{n, n_1}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_1.metric_name);
                }
                {
                    var prefix_buf: [256]u8 = undefined;
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&StatisticsConfigurations.member.{d}.IncludeMetrics.member.{d}.Namespace=", .{n, n_1}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, item_1.namespace);
                }
            }
        }
    }
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Key=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.key);
            }
            {
                var prefix_buf: [256]u8 = undefined;
                const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.member.{d}.Value=", .{n}) catch continue;
                try body_buf.appendSlice(allocator, field_prefix);
                try aws.url.appendUrlEncoded(allocator, &body_buf, item.value);
            }
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutMetricStreamOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "PutMetricStreamResult")) break;
            },
            else => {},
        }
    }

    var result: PutMetricStreamOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
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
