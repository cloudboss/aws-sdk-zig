const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetricTransformation = @import("metric_transformation.zig").MetricTransformation;

pub const PutMetricFilterInput = struct {
    /// This parameter is valid only for log groups that have an active log
    /// transformer. For more
    /// information about log transformers, see
    /// [PutTransformer](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_PutTransformer.html).
    ///
    /// If the log group uses either a log-group level or account-level transformer,
    /// and you
    /// specify `true`, the metric filter will be applied on the transformed version
    /// of the
    /// log events instead of the original ingested log events.
    apply_on_transformed_logs: ?bool = null,

    /// A list of system fields to emit as additional dimensions in the generated
    /// metrics. Valid
    /// values are `@aws.account` and `@aws.region`. These dimensions help
    /// identify the source of centralized log data and count toward the total
    /// dimension limit for
    /// metric filters.
    emit_system_field_dimensions: ?[]const []const u8 = null,

    /// A filter expression that specifies which log events should be processed by
    /// this metric
    /// filter based on system fields such as source account and source region. Uses
    /// selection
    /// criteria syntax with operators like `=`, `!=`, `AND`,
    /// `OR`, `IN`, `NOT IN`. Example: `@aws.region =
    /// "us-east-1"` or `@aws.account IN ["123456789012", "987654321098"]`. Maximum
    /// length: 2000 characters.
    field_selection_criteria: ?[]const u8 = null,

    /// A name for the metric filter.
    filter_name: []const u8,

    /// A filter pattern for extracting metric data out of ingested log events.
    filter_pattern: []const u8,

    /// The name of the log group.
    log_group_name: []const u8,

    /// A collection of information that defines how metric data gets emitted.
    metric_transformations: []const MetricTransformation,

    pub const json_field_names = .{
        .apply_on_transformed_logs = "applyOnTransformedLogs",
        .emit_system_field_dimensions = "emitSystemFieldDimensions",
        .field_selection_criteria = "fieldSelectionCriteria",
        .filter_name = "filterName",
        .filter_pattern = "filterPattern",
        .log_group_name = "logGroupName",
        .metric_transformations = "metricTransformations",
    };
};

pub const PutMetricFilterOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutMetricFilterInput, options: CallOptions) !PutMetricFilterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutMetricFilterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.PutMetricFilter");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutMetricFilterOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
