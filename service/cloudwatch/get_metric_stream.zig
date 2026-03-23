const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const MetricStreamFilter = @import("metric_stream_filter.zig").MetricStreamFilter;
const MetricStreamOutputFormat = @import("metric_stream_output_format.zig").MetricStreamOutputFormat;
const MetricStreamStatisticsConfiguration = @import("metric_stream_statistics_configuration.zig").MetricStreamStatisticsConfiguration;
const serde = @import("serde.zig");

pub const GetMetricStreamInput = struct {
    /// The name of the metric stream to retrieve information about.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const GetMetricStreamOutput = struct {
    /// The ARN of the metric stream.
    arn: ?[]const u8 = null,

    /// The date that the metric stream was created.
    creation_date: ?i64 = null,

    /// If this array of metric namespaces is present, then these namespaces are the
    /// only
    /// metric namespaces that are not streamed by this metric stream. In this case,
    /// all other
    /// metric namespaces in the account are streamed by this metric stream.
    exclude_filters: ?[]const MetricStreamFilter = null,

    /// The ARN of the Amazon Kinesis Data Firehose delivery stream that is used by
    /// this
    /// metric stream.
    firehose_arn: ?[]const u8 = null,

    /// If this array of metric namespaces is present, then these namespaces are the
    /// only
    /// metric namespaces that are streamed by this metric stream.
    include_filters: ?[]const MetricStreamFilter = null,

    /// If this is `true` and this metric stream is in a monitoring account, then
    /// the stream includes metrics from source accounts that the monitoring account
    /// is linked
    /// to.
    include_linked_accounts_metrics: ?bool = null,

    /// The date of the most recent update to the metric stream's configuration.
    last_update_date: ?i64 = null,

    /// The name of the metric stream.
    name: ?[]const u8 = null,

    /// The output format for the stream. Valid values are `json`,
    /// `opentelemetry1.0`, and `opentelemetry0.7`. For more
    /// information about metric stream output formats, see [Metric streams output
    /// formats](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-metric-streams-formats.html).
    output_format: ?MetricStreamOutputFormat = null,

    /// The ARN of the IAM role that is used by this metric stream.
    role_arn: ?[]const u8 = null,

    /// The state of the metric stream. The possible values are `running` and
    /// `stopped`.
    state: ?[]const u8 = null,

    /// Each entry in this array displays information about one or more metrics that
    /// include
    /// additional statistics in the metric stream. For more information about the
    /// additional
    /// statistics, see [
    /// CloudWatch statistics
    /// definitions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Statistics-definitions.html.html).
    statistics_configurations: ?[]const MetricStreamStatisticsConfiguration = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_date = "CreationDate",
        .exclude_filters = "ExcludeFilters",
        .firehose_arn = "FirehoseArn",
        .include_filters = "IncludeFilters",
        .include_linked_accounts_metrics = "IncludeLinkedAccountsMetrics",
        .last_update_date = "LastUpdateDate",
        .name = "Name",
        .output_format = "OutputFormat",
        .role_arn = "RoleArn",
        .state = "State",
        .statistics_configurations = "StatisticsConfigurations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMetricStreamInput, options: CallOptions) !GetMetricStreamOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMetricStreamInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=GetMetricStream&Version=2010-08-01");
    try body_buf.appendSlice(allocator, "&Name=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.name);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMetricStreamOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetMetricStreamResult")) break;
            },
            else => {},
        }
    }

    var result: GetMetricStreamOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "CreationDate")) {
                    result.creation_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "ExcludeFilters")) {
                    result.exclude_filters = try serde.deserializeMetricStreamFilters(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "FirehoseArn")) {
                    result.firehose_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "IncludeFilters")) {
                    result.include_filters = try serde.deserializeMetricStreamFilters(allocator, &reader, "member");
                } else if (std.mem.eql(u8, e.local, "IncludeLinkedAccountsMetrics")) {
                    result.include_linked_accounts_metrics = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "LastUpdateDate")) {
                    result.last_update_date = aws.date.parseIso8601(try reader.readElementText()) catch null;
                } else if (std.mem.eql(u8, e.local, "Name")) {
                    result.name = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "OutputFormat")) {
                    result.output_format = MetricStreamOutputFormat.fromWireName(try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "RoleArn")) {
                    result.role_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "State")) {
                    result.state = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "StatisticsConfigurations")) {
                    result.statistics_configurations = try serde.deserializeMetricStreamStatisticsConfigurations(allocator, &reader, "member");
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
