const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetricDestination = @import("metric_destination.zig").MetricDestination;
const BatchDeleteRumMetricDefinitionsError = @import("batch_delete_rum_metric_definitions_error.zig").BatchDeleteRumMetricDefinitionsError;

pub const BatchDeleteRumMetricDefinitionsInput = struct {
    /// The name of the CloudWatch RUM app monitor that is sending these metrics.
    app_monitor_name: []const u8,

    /// Defines the destination where you want to stop sending the specified
    /// metrics. Valid values are `CloudWatch` and `Evidently`. If you specify
    /// `Evidently`, you must also specify the ARN of the CloudWatchEvidently
    /// experiment that is to be the destination and an IAM role that has permission
    /// to write to the experiment.
    destination: MetricDestination,

    /// This parameter is required if `Destination` is `Evidently`. If `Destination`
    /// is `CloudWatch`, do not use this parameter.
    ///
    /// This parameter specifies the ARN of the Evidently experiment that was
    /// receiving the metrics that are being deleted.
    destination_arn: ?[]const u8 = null,

    /// An array of structures which define the metrics that you want to stop
    /// sending.
    metric_definition_ids: []const []const u8,

    pub const json_field_names = .{
        .app_monitor_name = "AppMonitorName",
        .destination = "Destination",
        .destination_arn = "DestinationArn",
        .metric_definition_ids = "MetricDefinitionIds",
    };
};

pub const BatchDeleteRumMetricDefinitionsOutput = struct {
    /// An array of error objects, if the operation caused any errors.
    errors: ?[]const BatchDeleteRumMetricDefinitionsError = null,

    /// The IDs of the metric definitions that were deleted.
    metric_definition_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .errors = "Errors",
        .metric_definition_ids = "MetricDefinitionIds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDeleteRumMetricDefinitionsInput, options: CallOptions) !BatchDeleteRumMetricDefinitionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rum", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDeleteRumMetricDefinitionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rum", "RUM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/rummetrics/");
    try path_buf.appendSlice(allocator, input.app_monitor_name);
    try path_buf.appendSlice(allocator, "/metrics");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "destination=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.destination.wireName());
    query_has_prev = true;
    if (input.destination_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "destinationArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    for (input.metric_definition_ids) |item| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "metricDefinitionIds=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, item);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDeleteRumMetricDefinitionsOutput {
    var result: BatchDeleteRumMetricDefinitionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchDeleteRumMetricDefinitionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
