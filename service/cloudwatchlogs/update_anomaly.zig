const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SuppressionPeriod = @import("suppression_period.zig").SuppressionPeriod;
const SuppressionType = @import("suppression_type.zig").SuppressionType;

pub const UpdateAnomalyInput = struct {
    /// The ARN of the anomaly detector that this operation is to act on.
    anomaly_detector_arn: []const u8,

    /// If you are suppressing or unsuppressing an anomaly, specify its unique ID
    /// here. You can
    /// find anomaly IDs by using the
    /// [ListAnomalies](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_ListAnomalies.html)
    /// operation.
    anomaly_id: ?[]const u8 = null,

    /// Set this to `true` to prevent CloudWatch Logs from displaying this behavior
    /// as an anomaly in the future. The behavior is then treated as baseline
    /// behavior. However, if
    /// similar but more severe occurrences of this behavior occur in the future,
    /// those will still be
    /// reported as anomalies.
    ///
    /// The default is `false`
    baseline: ?bool = null,

    /// If you are suppressing or unsuppressing an pattern, specify its unique ID
    /// here. You can
    /// find pattern IDs by using the
    /// [ListAnomalies](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_ListAnomalies.html)
    /// operation.
    pattern_id: ?[]const u8 = null,

    /// If you are temporarily suppressing an anomaly or pattern, use this structure
    /// to specify
    /// how long the suppression is to last.
    suppression_period: ?SuppressionPeriod = null,

    /// Use this to specify whether the suppression to be temporary or infinite. If
    /// you specify
    /// `LIMITED`, you must also specify a `suppressionPeriod`. If you specify
    /// `INFINITE`, any value for `suppressionPeriod` is ignored.
    suppression_type: ?SuppressionType = null,

    pub const json_field_names = .{
        .anomaly_detector_arn = "anomalyDetectorArn",
        .anomaly_id = "anomalyId",
        .baseline = "baseline",
        .pattern_id = "patternId",
        .suppression_period = "suppressionPeriod",
        .suppression_type = "suppressionType",
    };
};

pub const UpdateAnomalyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAnomalyInput, options: CallOptions) !UpdateAnomalyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAnomalyInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.UpdateAnomaly");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAnomalyOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
