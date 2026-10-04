const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnomalyDetector = @import("anomaly_detector.zig").AnomalyDetector;

pub const ListLogAnomalyDetectorsInput = struct {
    /// Use this to optionally filter the results to only include anomaly detectors
    /// that are
    /// associated with the specified log group.
    filter_log_group_arn: ?[]const u8 = null,

    /// The maximum number of items to return. If you don't specify a value, the
    /// default
    /// maximum value of 50 items is used.
    limit: ?i32 = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter_log_group_arn = "filterLogGroupArn",
        .limit = "limit",
        .next_token = "nextToken",
    };
};

pub const ListLogAnomalyDetectorsOutput = struct {
    /// An array of structures, where each structure in the array contains
    /// information about one
    /// anomaly detector.
    anomaly_detectors: ?[]const AnomalyDetector = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .anomaly_detectors = "anomalyDetectors",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLogAnomalyDetectorsInput, options: CallOptions) !ListLogAnomalyDetectorsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLogAnomalyDetectorsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.ListLogAnomalyDetectors");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLogAnomalyDetectorsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListLogAnomalyDetectorsOutput, body, allocator);
}
