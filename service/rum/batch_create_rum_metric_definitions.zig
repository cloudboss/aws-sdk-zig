const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const MetricDestination = @import("metric_destination.zig").MetricDestination;
const MetricDefinitionRequest = @import("metric_definition_request.zig").MetricDefinitionRequest;
const BatchCreateRumMetricDefinitionsError = @import("batch_create_rum_metric_definitions_error.zig").BatchCreateRumMetricDefinitionsError;
const MetricDefinition = @import("metric_definition.zig").MetricDefinition;

pub const BatchCreateRumMetricDefinitionsInput = struct {
    /// The name of the CloudWatch RUM app monitor that is to send the metrics.
    app_monitor_name: []const u8,

    /// The destination to send the metrics to. Valid values are `CloudWatch` and
    /// `Evidently`. If you specify `Evidently`, you must also specify the Amazon
    /// Resource Name (ARN) of the CloudWatchEvidently experiment that will receive
    /// the metrics and an IAM role that has permission to write to the experiment.
    destination: MetricDestination,

    /// This parameter is required if `Destination` is `Evidently`. If `Destination`
    /// is `CloudWatch`, do not use this parameter.
    ///
    /// This parameter specifies the ARN of the Evidently experiment that is to
    /// receive the metrics. You must have already defined this experiment as a
    /// valid destination. For more information, see
    /// [PutRumMetricsDestination](https://docs.aws.amazon.com/cloudwatchrum/latest/APIReference/API_PutRumMetricsDestination.html).
    destination_arn: ?[]const u8 = null,

    /// An array of structures which define the metrics that you want to send.
    metric_definitions: []const MetricDefinitionRequest,

    pub const json_field_names = .{
        .app_monitor_name = "AppMonitorName",
        .destination = "Destination",
        .destination_arn = "DestinationArn",
        .metric_definitions = "MetricDefinitions",
    };
};

pub const BatchCreateRumMetricDefinitionsOutput = struct {
    /// An array of error objects, if the operation caused any errors.
    errors: ?[]const BatchCreateRumMetricDefinitionsError = null,

    /// An array of structures that define the extended metrics.
    metric_definitions: ?[]const MetricDefinition = null,

    pub const json_field_names = .{
        .errors = "Errors",
        .metric_definitions = "MetricDefinitions",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchCreateRumMetricDefinitionsInput, options: Options) !BatchCreateRumMetricDefinitionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "rum");

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchCreateRumMetricDefinitionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rum", "RUM", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/rummetrics/");
    try path_buf.appendSlice(allocator, input.app_monitor_name);
    try path_buf.appendSlice(allocator, "/metrics");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Destination\":");
    try aws.json.writeValue(@TypeOf(input.destination), input.destination, allocator, &body_buf);
    has_prev = true;
    if (input.destination_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DestinationArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MetricDefinitions\":");
    try aws.json.writeValue(@TypeOf(input.metric_definitions), input.metric_definitions, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchCreateRumMetricDefinitionsOutput {
    var result: BatchCreateRumMetricDefinitionsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchCreateRumMetricDefinitionsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyRevisionIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_revision_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyDocumentException")) {
        return .{ .arena = arena, .kind = .{ .malformed_policy_document_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .policy_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicySizeLimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .policy_size_limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
