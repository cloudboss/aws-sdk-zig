const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetTrailStatusInput = struct {
    /// Specifies the name or the CloudTrail ARN of the trail for which you are
    /// requesting status. To get the status of a shadow trail (a replication of the
    /// trail in
    /// another Region), you must specify its ARN.
    ///
    /// The following is the format of a trail
    /// ARN: `arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail`
    ///
    /// If the trail is an organization trail and you are a member account in the
    /// organization in Organizations, you must provide the full ARN of that trail,
    /// and not just the name.
    name: []const u8,

    pub const json_field_names = .{
        .name = "Name",
    };
};

pub const GetTrailStatusOutput = struct {
    /// Whether the CloudTrail trail is currently logging Amazon Web Services API
    /// calls.
    is_logging: ?bool = null,

    /// Displays any CloudWatch Logs error that CloudTrail encountered when
    /// attempting
    /// to deliver logs to CloudWatch Logs.
    latest_cloud_watch_logs_delivery_error: ?[]const u8 = null,

    /// Displays the most recent date and time when CloudTrail delivered logs to
    /// CloudWatch Logs.
    latest_cloud_watch_logs_delivery_time: ?i64 = null,

    /// This field is no longer in use.
    latest_delivery_attempt_succeeded: ?[]const u8 = null,

    /// This field is no longer in use.
    latest_delivery_attempt_time: ?[]const u8 = null,

    /// Displays any Amazon S3 error that CloudTrail encountered when attempting
    /// to deliver log files to the designated bucket. For more information, see
    /// [Error
    /// Responses](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html) in the Amazon S3 API Reference.
    ///
    /// This error occurs only when there is a problem with the destination S3
    /// bucket, and
    /// does not occur for requests that time out. To resolve the issue,
    /// fix the [bucket
    /// policy](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/create-s3-bucket-policy-for-cloudtrail.html) so that CloudTrail
    /// can write to the bucket; or create a new bucket and call `UpdateTrail` to
    /// specify the new bucket.
    latest_delivery_error: ?[]const u8 = null,

    /// Specifies the date and time that CloudTrail last delivered log files to an
    /// account's Amazon S3 bucket.
    latest_delivery_time: ?i64 = null,

    /// Displays any Amazon S3 error that CloudTrail encountered when attempting
    /// to deliver a digest file to the designated bucket. For more information, see
    /// [Error
    /// Responses](https://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html) in the Amazon S3 API Reference.
    ///
    /// This error occurs only when there is a problem with the destination S3
    /// bucket, and
    /// does not occur for requests that time out. To resolve the issue,
    /// fix the [bucket
    /// policy](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/create-s3-bucket-policy-for-cloudtrail.html) so that CloudTrail
    /// can write to the bucket; or create a new bucket and call `UpdateTrail` to
    /// specify the new bucket.
    latest_digest_delivery_error: ?[]const u8 = null,

    /// Specifies the date and time that CloudTrail last delivered a digest file to
    /// an
    /// account's Amazon S3 bucket.
    latest_digest_delivery_time: ?i64 = null,

    /// This field is no longer in use.
    latest_notification_attempt_succeeded: ?[]const u8 = null,

    /// This field is no longer in use.
    latest_notification_attempt_time: ?[]const u8 = null,

    /// Displays any Amazon SNS error that CloudTrail encountered when attempting
    /// to send a notification. For more information about Amazon SNS errors, see
    /// the
    /// [Amazon SNS
    /// Developer Guide](https://docs.aws.amazon.com/sns/latest/dg/welcome.html).
    latest_notification_error: ?[]const u8 = null,

    /// Specifies the date and time of the most recent Amazon SNS notification that
    /// CloudTrail has written a new log file to an account's Amazon S3
    /// bucket.
    latest_notification_time: ?i64 = null,

    /// Specifies the most recent date and time when CloudTrail started recording
    /// API
    /// calls for an Amazon Web Services account.
    start_logging_time: ?i64 = null,

    /// Specifies the most recent date and time when CloudTrail stopped recording
    /// API
    /// calls for an Amazon Web Services account.
    stop_logging_time: ?i64 = null,

    /// This field is no longer in use.
    time_logging_started: ?[]const u8 = null,

    /// This field is no longer in use.
    time_logging_stopped: ?[]const u8 = null,

    pub const json_field_names = .{
        .is_logging = "IsLogging",
        .latest_cloud_watch_logs_delivery_error = "LatestCloudWatchLogsDeliveryError",
        .latest_cloud_watch_logs_delivery_time = "LatestCloudWatchLogsDeliveryTime",
        .latest_delivery_attempt_succeeded = "LatestDeliveryAttemptSucceeded",
        .latest_delivery_attempt_time = "LatestDeliveryAttemptTime",
        .latest_delivery_error = "LatestDeliveryError",
        .latest_delivery_time = "LatestDeliveryTime",
        .latest_digest_delivery_error = "LatestDigestDeliveryError",
        .latest_digest_delivery_time = "LatestDigestDeliveryTime",
        .latest_notification_attempt_succeeded = "LatestNotificationAttemptSucceeded",
        .latest_notification_attempt_time = "LatestNotificationAttemptTime",
        .latest_notification_error = "LatestNotificationError",
        .latest_notification_time = "LatestNotificationTime",
        .start_logging_time = "StartLoggingTime",
        .stop_logging_time = "StopLoggingTime",
        .time_logging_started = "TimeLoggingStarted",
        .time_logging_stopped = "TimeLoggingStopped",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTrailStatusInput, options: CallOptions) !GetTrailStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTrailStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.GetTrailStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTrailStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetTrailStatusOutput, body, allocator);
}
