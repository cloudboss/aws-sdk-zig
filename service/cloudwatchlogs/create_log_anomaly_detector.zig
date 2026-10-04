const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EvaluationFrequency = @import("evaluation_frequency.zig").EvaluationFrequency;

pub const CreateLogAnomalyDetectorInput = struct {
    /// The number of days to have visibility on an anomaly. After this time period
    /// has elapsed
    /// for an anomaly, it will be automatically baselined and the anomaly detector
    /// will treat new
    /// occurrences of a similar anomaly as normal. Therefore, if you do not correct
    /// the cause of an
    /// anomaly during the time period specified in `anomalyVisibilityTime`, it will
    /// be
    /// considered normal going forward and will not be detected as an anomaly.
    anomaly_visibility_time: ?i64 = null,

    /// A name for this anomaly detector.
    detector_name: ?[]const u8 = null,

    /// Specifies how often the anomaly detector is to run and look for anomalies.
    /// Set this value
    /// according to the frequency that the log group receives new logs. For
    /// example, if the log group
    /// receives new log events every 10 minutes, then 15 minutes might be a good
    /// setting for
    /// `evaluationFrequency` .
    evaluation_frequency: ?EvaluationFrequency = null,

    /// You can use this parameter to limit the anomaly detection model to examine
    /// only log events
    /// that match the pattern you specify here. For more information, see [Filter
    /// and Pattern
    /// Syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/FilterAndPatternSyntax.html).
    filter_pattern: ?[]const u8 = null,

    /// Optionally assigns a KMS key to secure this anomaly detector and its
    /// findings. If a key is assigned, the anomalies found and the model used by
    /// this detector are
    /// encrypted at rest with the key. If a key is assigned to an anomaly detector,
    /// a user must have
    /// permissions for both this key and for the anomaly detector to retrieve
    /// information about the
    /// anomalies that it finds.
    ///
    /// Make sure the value provided is a valid KMS key ARN. For more information
    /// about using a KMS key and to see the required IAM policy, see
    /// [Use a KMS key with an anomaly
    /// detector](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/LogsAnomalyDetection-KMS.html).
    kms_key_id: ?[]const u8 = null,

    /// An array containing the ARN of the log group that this anomaly detector will
    /// watch. You
    /// can specify only one log group ARN.
    log_group_arn_list: []const []const u8,

    /// An optional list of key-value pairs to associate with the resource.
    ///
    /// For more information about tagging, see [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .anomaly_visibility_time = "anomalyVisibilityTime",
        .detector_name = "detectorName",
        .evaluation_frequency = "evaluationFrequency",
        .filter_pattern = "filterPattern",
        .kms_key_id = "kmsKeyId",
        .log_group_arn_list = "logGroupArnList",
        .tags = "tags",
    };
};

pub const CreateLogAnomalyDetectorOutput = struct {
    /// The ARN of the log anomaly detector that you just created.
    anomaly_detector_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .anomaly_detector_arn = "anomalyDetectorArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLogAnomalyDetectorInput, options: CallOptions) !CreateLogAnomalyDetectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLogAnomalyDetectorInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.CreateLogAnomalyDetector");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLogAnomalyDetectorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLogAnomalyDetectorOutput, body, allocator);
}
