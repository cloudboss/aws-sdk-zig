const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotificationChannel = @import("notification_channel.zig").NotificationChannel;
const Video = @import("video.zig").Video;

pub const StartPersonTrackingInput = struct {
    /// Idempotent token used to identify the start request. If you use the same
    /// token with multiple
    /// `StartPersonTracking` requests, the same `JobId` is returned. Use
    /// `ClientRequestToken` to prevent the same job from being accidently started
    /// more than once.
    client_request_token: ?[]const u8 = null,

    /// An identifier you specify that's returned in the completion notification
    /// that's published to your Amazon Simple Notification Service topic.
    /// For example, you can use `JobTag` to group related jobs and identify them in
    /// the completion notification.
    job_tag: ?[]const u8 = null,

    /// The Amazon SNS topic ARN you want Amazon Rekognition Video to publish the
    /// completion status of the people detection
    /// operation to. The Amazon SNS topic must have a topic name that begins with
    /// *AmazonRekognition* if you are using the AmazonRekognitionServiceRole
    /// permissions policy.
    notification_channel: ?NotificationChannel = null,

    /// The video in which you want to detect people. The video must be stored
    /// in an Amazon S3 bucket.
    video: Video,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .job_tag = "JobTag",
        .notification_channel = "NotificationChannel",
        .video = "Video",
    };
};

pub const StartPersonTrackingOutput = struct {
    /// The identifier for the person detection job. Use `JobId` to identify the job
    /// in
    /// a subsequent call to `GetPersonTracking`.
    job_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartPersonTrackingInput, options: CallOptions) !StartPersonTrackingOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rekognition", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartPersonTrackingInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rekognition", "Rekognition", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.StartPersonTracking");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartPersonTrackingOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartPersonTrackingOutput, body, allocator);
}
