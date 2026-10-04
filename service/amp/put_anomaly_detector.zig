const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutAnomalyDetectorInput, options: CallOptions) !PutAnomalyDetectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aps", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("aps", "amp", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/anomalydetectors/");
    try path_buf.appendSlice(allocator, input.anomaly_detector_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"configuration\":");
    try aws.json.writeValue(@TypeOf(input.configuration), input.configuration, allocator, &body_buf);
    has_prev = true;
    if (input.evaluation_interval_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"evaluationIntervalInSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.labels) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"labels\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.missing_data_action) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"missingDataAction\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutAnomalyDetectorOutput {
    const result: PutAnomalyDetectorOutput = try aws.json.parseJsonObject(
        PutAnomalyDetectorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
