const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotificationChannel = @import("notification_channel.zig").NotificationChannel;
const Video = @import("video.zig").Video;

pub const StartContentModerationInput = struct {
    /// Idempotent token used to identify the start request. If you use the same
    /// token with multiple
    /// `StartContentModeration` requests, the same `JobId` is returned. Use
    /// `ClientRequestToken` to prevent the same job from being accidently started
    /// more than once.
    client_request_token: ?[]const u8 = null,

    /// An identifier you specify that's returned in the completion notification
    /// that's published to your Amazon Simple Notification Service topic.
    /// For example, you can use `JobTag` to group related jobs and identify them in
    /// the completion notification.
    job_tag: ?[]const u8 = null,

    /// Specifies the minimum confidence that Amazon Rekognition must have in order
    /// to return a moderated content label. Confidence
    /// represents how certain Amazon Rekognition is that the moderated content is
    /// correctly identified. 0 is the lowest confidence.
    /// 100 is the highest confidence. Amazon Rekognition doesn't return any
    /// moderated content labels with a confidence level
    /// lower than this specified value. If you don't specify `MinConfidence`,
    /// `GetContentModeration`
    /// returns labels with confidence values greater than or equal to 50 percent.
    min_confidence: ?f32 = null,

    /// The Amazon SNS topic ARN that you want Amazon Rekognition Video to publish
    /// the completion status of the
    /// content analysis to. The Amazon SNS topic must have a topic name that begins
    /// with *AmazonRekognition* if you are using the AmazonRekognitionServiceRole
    /// permissions policy to access the topic.
    notification_channel: ?NotificationChannel = null,

    /// The video in which you want to detect inappropriate, unwanted, or offensive
    /// content. The video must be stored
    /// in an Amazon S3 bucket.
    video: Video,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .job_tag = "JobTag",
        .min_confidence = "MinConfidence",
        .notification_channel = "NotificationChannel",
        .video = "Video",
    };
};

pub const StartContentModerationOutput = struct {
    /// The identifier for the content analysis job. Use `JobId` to identify the job
    /// in
    /// a subsequent call to `GetContentModeration`.
    job_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartContentModerationInput, options: CallOptions) !StartContentModerationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartContentModerationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.StartContentModeration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartContentModerationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartContentModerationOutput, body, allocator);
}
