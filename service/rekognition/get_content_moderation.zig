const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContentModerationAggregateBy = @import("content_moderation_aggregate_by.zig").ContentModerationAggregateBy;
const ContentModerationSortBy = @import("content_moderation_sort_by.zig").ContentModerationSortBy;
const GetContentModerationRequestMetadata = @import("get_content_moderation_request_metadata.zig").GetContentModerationRequestMetadata;
const VideoJobStatus = @import("video_job_status.zig").VideoJobStatus;
const ContentModerationDetection = @import("content_moderation_detection.zig").ContentModerationDetection;
const Video = @import("video.zig").Video;
const VideoMetadata = @import("video_metadata.zig").VideoMetadata;

pub const GetContentModerationInput = struct {
    /// Defines how to aggregate results of the StartContentModeration request.
    /// Default
    /// aggregation option is TIMESTAMPS. SEGMENTS mode aggregates moderation labels
    /// over time.
    aggregate_by: ?ContentModerationAggregateBy = null,

    /// The identifier for the inappropriate, unwanted, or offensive content
    /// moderation job. Use `JobId` to identify the job in
    /// a subsequent call to `GetContentModeration`.
    job_id: []const u8,

    /// Maximum number of results to return per paginated call. The largest value
    /// you can specify is 1000.
    /// If you specify a value greater than 1000, a maximum of 1000 results is
    /// returned.
    /// The default value is 1000.
    max_results: ?i32 = null,

    /// If the previous response was incomplete (because there is more data to
    /// retrieve), Amazon Rekognition
    /// returns a pagination token in the response. You can use this pagination
    /// token
    /// to retrieve the next set of content moderation labels.
    next_token: ?[]const u8 = null,

    /// Sort to use for elements in the `ModerationLabelDetections` array.
    /// Use `TIMESTAMP` to sort array elements by the time labels are detected.
    /// Use `NAME` to alphabetically group elements for a label together.
    /// Within each label group, the array element are sorted by detection
    /// confidence.
    /// The default sort is by `TIMESTAMP`.
    sort_by: ?ContentModerationSortBy = null,

    pub const json_field_names = .{
        .aggregate_by = "AggregateBy",
        .job_id = "JobId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_by = "SortBy",
    };
};

pub const GetContentModerationOutput = struct {
    /// Information about the paramters used when getting a response. Includes
    /// information on
    /// aggregation and sorting methods.
    get_request_metadata: ?GetContentModerationRequestMetadata = null,

    /// Job identifier for the content moderation operation for which you want to
    /// obtain results.
    /// The job identifer is returned by an initial call to StartContentModeration.
    job_id: ?[]const u8 = null,

    /// The current status of the content moderation analysis job.
    job_status: ?VideoJobStatus = null,

    /// A job identifier specified in the call to StartContentModeration and
    /// returned in the job
    /// completion notification sent to your Amazon Simple Notification Service
    /// topic.
    job_tag: ?[]const u8 = null,

    /// The detected inappropriate, unwanted, or offensive content moderation labels
    /// and the time(s) they were detected.
    moderation_labels: ?[]const ContentModerationDetection = null,

    /// Version number of the moderation detection model that was used to detect
    /// inappropriate, unwanted, or offensive content.
    moderation_model_version: ?[]const u8 = null,

    /// If the response is truncated, Amazon Rekognition Video returns this token
    /// that you can use in the subsequent
    /// request to retrieve the next set of content moderation labels.
    next_token: ?[]const u8 = null,

    /// If the job fails, `StatusMessage` provides a descriptive error message.
    status_message: ?[]const u8 = null,

    video: ?Video = null,

    /// Information about a video that Amazon Rekognition analyzed. `Videometadata`
    /// is returned in every page of paginated responses from
    /// `GetContentModeration`.
    video_metadata: ?VideoMetadata = null,

    pub const json_field_names = .{
        .get_request_metadata = "GetRequestMetadata",
        .job_id = "JobId",
        .job_status = "JobStatus",
        .job_tag = "JobTag",
        .moderation_labels = "ModerationLabels",
        .moderation_model_version = "ModerationModelVersion",
        .next_token = "NextToken",
        .status_message = "StatusMessage",
        .video = "Video",
        .video_metadata = "VideoMetadata",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetContentModerationInput, options: CallOptions) !GetContentModerationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetContentModerationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.GetContentModeration");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetContentModerationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetContentModerationOutput, body, allocator);
}
