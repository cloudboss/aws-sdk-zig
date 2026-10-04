const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VideoJobStatus = @import("video_job_status.zig").VideoJobStatus;
const TextDetectionResult = @import("text_detection_result.zig").TextDetectionResult;
const Video = @import("video.zig").Video;
const VideoMetadata = @import("video_metadata.zig").VideoMetadata;

pub const GetTextDetectionInput = struct {
    /// Job identifier for the text detection operation for which you want results
    /// returned.
    /// You get the job identifer from an initial call to `StartTextDetection`.
    job_id: []const u8,

    /// Maximum number of results to return per paginated call. The largest value
    /// you can specify is 1000.
    max_results: ?i32 = null,

    /// If the previous response was incomplete (because there are more labels to
    /// retrieve), Amazon Rekognition Video returns
    /// a pagination token in the response. You can use this pagination token to
    /// retrieve the next set of text.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_id = "JobId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const GetTextDetectionOutput = struct {
    /// Job identifier for the text detection operation for which you want to obtain
    /// results. The
    /// job identifer is returned by an initial call to StartTextDetection.
    job_id: ?[]const u8 = null,

    /// Current status of the text detection job.
    job_status: ?VideoJobStatus = null,

    /// A job identifier specified in the call to StartTextDetection and returned in
    /// the job
    /// completion notification sent to your Amazon Simple Notification Service
    /// topic.
    job_tag: ?[]const u8 = null,

    /// If the response is truncated, Amazon Rekognition Video returns this token
    /// that you can use in the subsequent
    /// request to retrieve the next set of text.
    next_token: ?[]const u8 = null,

    /// If the job fails, `StatusMessage` provides a descriptive error message.
    status_message: ?[]const u8 = null,

    /// An array of text detected in the video. Each element contains the detected
    /// text, the time in milliseconds
    /// from the start of the video that the text was detected, and where it was
    /// detected on the screen.
    text_detections: ?[]const TextDetectionResult = null,

    /// Version number of the text detection model that was used to detect text.
    text_model_version: ?[]const u8 = null,

    video: ?Video = null,

    video_metadata: ?VideoMetadata = null,

    pub const json_field_names = .{
        .job_id = "JobId",
        .job_status = "JobStatus",
        .job_tag = "JobTag",
        .next_token = "NextToken",
        .status_message = "StatusMessage",
        .text_detections = "TextDetections",
        .text_model_version = "TextModelVersion",
        .video = "Video",
        .video_metadata = "VideoMetadata",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTextDetectionInput, options: CallOptions) !GetTextDetectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTextDetectionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.GetTextDetection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTextDetectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetTextDetectionOutput, body, allocator);
}
