const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SuppressionState = @import("suppression_state.zig").SuppressionState;
const Anomaly = @import("anomaly.zig").Anomaly;

pub const ListAnomaliesInput = struct {
    /// Use this to optionally limit the results to only the anomalies found by a
    /// certain anomaly
    /// detector.
    anomaly_detector_arn: ?[]const u8 = null,

    /// The maximum number of items to return. If you don't specify a value, the
    /// default
    /// maximum value of 50 items is used.
    limit: ?i32 = null,

    next_token: ?[]const u8 = null,

    /// You can specify this parameter if you want to the operation to return only
    /// anomalies that
    /// are currently either suppressed or unsuppressed.
    suppression_state: ?SuppressionState = null,

    pub const json_field_names = .{
        .anomaly_detector_arn = "anomalyDetectorArn",
        .limit = "limit",
        .next_token = "nextToken",
        .suppression_state = "suppressionState",
    };
};

pub const ListAnomaliesOutput = struct {
    /// An array of structures, where each structure contains information about one
    /// anomaly that a
    /// log anomaly detector has found.
    anomalies: ?[]const Anomaly = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .anomalies = "anomalies",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAnomaliesInput, options: CallOptions) !ListAnomaliesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAnomaliesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.ListAnomalies");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAnomaliesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAnomaliesOutput, body, allocator);
}
