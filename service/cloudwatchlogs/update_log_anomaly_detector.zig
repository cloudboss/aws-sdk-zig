const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EvaluationFrequency = @import("evaluation_frequency.zig").EvaluationFrequency;

pub const UpdateLogAnomalyDetectorInput = struct {
    /// The ARN of the anomaly detector that you want to update.
    anomaly_detector_arn: []const u8,

    /// The number of days to use as the life cycle of anomalies. After this time,
    /// anomalies are
    /// automatically baselined and the anomaly detector model will treat new
    /// occurrences of similar
    /// event as normal. Therefore, if you do not correct the cause of an anomaly
    /// during this time, it
    /// will be considered normal going forward and will not be detected.
    anomaly_visibility_time: ?i64 = null,

    /// Use this parameter to pause or restart the anomaly detector.
    enabled: bool,

    /// Specifies how often the anomaly detector runs and look for anomalies. Set
    /// this value
    /// according to the frequency that the log group receives new logs. For
    /// example, if the log group
    /// receives new log events every 10 minutes, then setting `evaluationFrequency`
    /// to
    /// `FIFTEEN_MIN` might be appropriate.
    evaluation_frequency: ?EvaluationFrequency = null,

    filter_pattern: ?[]const u8 = null,

    pub const json_field_names = .{
        .anomaly_detector_arn = "anomalyDetectorArn",
        .anomaly_visibility_time = "anomalyVisibilityTime",
        .enabled = "enabled",
        .evaluation_frequency = "evaluationFrequency",
        .filter_pattern = "filterPattern",
    };
};

pub const UpdateLogAnomalyDetectorOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateLogAnomalyDetectorInput, options: CallOptions) !UpdateLogAnomalyDetectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateLogAnomalyDetectorInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.UpdateLogAnomalyDetector");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateLogAnomalyDetectorOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
