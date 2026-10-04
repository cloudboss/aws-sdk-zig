const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AnomalyDetectorStatus = @import("anomaly_detector_status.zig").AnomalyDetectorStatus;
const EvaluationFrequency = @import("evaluation_frequency.zig").EvaluationFrequency;

pub const GetLogAnomalyDetectorInput = struct {
    /// The ARN of the anomaly detector to retrieve information about. You can find
    /// the ARNs of
    /// log anomaly detectors in your account by using the
    /// [ListLogAnomalyDetectors](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_ListLogAnomalyDetectors.html) operation.
    anomaly_detector_arn: []const u8,

    pub const json_field_names = .{
        .anomaly_detector_arn = "anomalyDetectorArn",
    };
};

pub const GetLogAnomalyDetectorOutput = struct {
    /// Specifies whether the anomaly detector is currently active. To change its
    /// status, use the
    /// `enabled` parameter in the
    /// [UpdateLogAnomalyDetector](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_UpdateLogAnomalyDetector.html) operation.
    anomaly_detector_status: ?AnomalyDetectorStatus = null,

    /// The number of days used as the life cycle of anomalies. After this time,
    /// anomalies are
    /// automatically baselined and the anomaly detector model will treat new
    /// occurrences of similar
    /// event as normal.
    anomaly_visibility_time: ?i64 = null,

    /// The date and time when this anomaly detector was created.
    creation_time_stamp: ?i64 = null,

    /// The name of the log anomaly detector
    detector_name: ?[]const u8 = null,

    /// Specifies how often the anomaly detector runs and look for anomalies. Set
    /// this value
    /// according to the frequency that the log group receives new logs. For
    /// example, if the log group
    /// receives new log events every 10 minutes, then setting `evaluationFrequency`
    /// to
    /// `FIFTEEN_MIN` might be appropriate.
    evaluation_frequency: ?EvaluationFrequency = null,

    filter_pattern: ?[]const u8 = null,

    /// The ARN of the KMS key assigned to this anomaly detector, if any.
    kms_key_id: ?[]const u8 = null,

    /// The date and time when this anomaly detector was most recently modified.
    last_modified_time_stamp: ?i64 = null,

    /// An array of structures, where each structure contains the ARN of a log group
    /// associated
    /// with this anomaly detector.
    log_group_arn_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .anomaly_detector_status = "anomalyDetectorStatus",
        .anomaly_visibility_time = "anomalyVisibilityTime",
        .creation_time_stamp = "creationTimeStamp",
        .detector_name = "detectorName",
        .evaluation_frequency = "evaluationFrequency",
        .filter_pattern = "filterPattern",
        .kms_key_id = "kmsKeyId",
        .last_modified_time_stamp = "lastModifiedTimeStamp",
        .log_group_arn_list = "logGroupArnList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetLogAnomalyDetectorInput, options: CallOptions) !GetLogAnomalyDetectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetLogAnomalyDetectorInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.GetLogAnomalyDetector");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetLogAnomalyDetectorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetLogAnomalyDetectorOutput, body, allocator);
}
