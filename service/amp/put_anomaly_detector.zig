const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AnomalyDetectorConfiguration = @import("anomaly_detector_configuration.zig").AnomalyDetectorConfiguration;
const AnomalyDetectorMissingDataAction = @import("anomaly_detector_missing_data_action.zig").AnomalyDetectorMissingDataAction;
const AnomalyDetectorStatus = @import("anomaly_detector_status.zig").AnomalyDetectorStatus;

pub const PutAnomalyDetectorInput = struct {
    /// The identifier of the anomaly detector to update.
    anomaly_detector_id: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The algorithm configuration for the anomaly detector.
    configuration: AnomalyDetectorConfiguration,

    /// The frequency, in seconds, at which the anomaly detector evaluates metrics.
    evaluation_interval_in_seconds: ?i32 = null,

    /// The Amazon Managed Service for Prometheus metric labels to associate with
    /// the anomaly detector.
    labels: ?[]const aws.map.StringMapEntry = null,

    /// Specifies the action to take when data is missing during evaluation.
    missing_data_action: ?AnomalyDetectorMissingDataAction = null,

    /// The identifier of the workspace containing the anomaly detector to update.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .anomaly_detector_id = "anomalyDetectorId",
        .client_token = "clientToken",
        .configuration = "configuration",
        .evaluation_interval_in_seconds = "evaluationIntervalInSeconds",
        .labels = "labels",
        .missing_data_action = "missingDataAction",
        .workspace_id = "workspaceId",
    };
};

pub const PutAnomalyDetectorOutput = struct {
    /// The unique identifier of the updated anomaly detector.
    anomaly_detector_id: []const u8,

    /// The Amazon Resource Name (ARN) of the updated anomaly detector.
    arn: []const u8,

    /// The status information of the updated anomaly detector.
    status: ?AnomalyDetectorStatus = null,

    /// The tags applied to the updated anomaly detector.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .anomaly_detector_id = "anomalyDetectorId",
        .arn = "arn",
        .status = "status",
        .tags = "tags",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAnomalyDetectorInput, options: Options) !PutAnomalyDetectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "amp");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: PutAnomalyDetectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("amp", "amp", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/workspaces/");
    try path_buf.appendSlice(alloc, input.workspace_id);
    try path_buf.appendSlice(alloc, "/anomalydetectors/");
    try path_buf.appendSlice(alloc, input.anomaly_detector_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"configuration\":");
    try aws.json.writeValue(@TypeOf(input.configuration), input.configuration, alloc, &body_buf);
    has_prev = true;
    if (input.evaluation_interval_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"evaluationIntervalInSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.labels) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"labels\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.missing_data_action) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"missingDataAction\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutAnomalyDetectorOutput {
    var result: PutAnomalyDetectorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutAnomalyDetectorOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
