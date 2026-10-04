const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AudioMetadata = @import("audio_metadata.zig").AudioMetadata;
const VideoJobStatus = @import("video_job_status.zig").VideoJobStatus;
const SegmentDetection = @import("segment_detection.zig").SegmentDetection;
const SegmentTypeInfo = @import("segment_type_info.zig").SegmentTypeInfo;
const Video = @import("video.zig").Video;
const VideoMetadata = @import("video_metadata.zig").VideoMetadata;

pub const GetSegmentDetectionInput = struct {
    /// Job identifier for the text detection operation for which you want results
    /// returned.
    /// You get the job identifer from an initial call to `StartSegmentDetection`.
    job_id: []const u8,

    /// Maximum number of results to return per paginated call. The largest value
    /// you can specify is 1000.
    max_results: ?i32 = null,

    /// If the response is truncated, Amazon Rekognition Video returns this token
    /// that you can use in the subsequent
    /// request to retrieve the next set of text.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_id = "JobId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const GetSegmentDetectionOutput = struct {
    /// An array of
    /// objects. There can be multiple audio streams.
    /// Each `AudioMetadata` object contains metadata for a single audio stream.
    /// Audio information in an `AudioMetadata` objects includes
    /// the audio codec, the number of audio channels, the duration of the audio
    /// stream,
    /// and the sample rate. Audio metadata is returned in each page of information
    /// returned
    /// by `GetSegmentDetection`.
    audio_metadata: ?[]const AudioMetadata = null,

    /// Job identifier for the segment detection operation for which you want to
    /// obtain results.
    /// The job identifer is returned by an initial call to StartSegmentDetection.
    job_id: ?[]const u8 = null,

    /// Current status of the segment detection job.
    job_status: ?VideoJobStatus = null,

    /// A job identifier specified in the call to StartSegmentDetection and returned
    /// in the job
    /// completion notification sent to your Amazon Simple Notification Service
    /// topic.
    job_tag: ?[]const u8 = null,

    /// If the previous response was incomplete (because there are more labels to
    /// retrieve), Amazon Rekognition Video returns
    /// a pagination token in the response. You can use this pagination token to
    /// retrieve the next set of text.
    next_token: ?[]const u8 = null,

    /// An array of segments detected in a video. The array is sorted by the segment
    /// types (TECHNICAL_CUE or SHOT)
    /// specified in the `SegmentTypes` input parameter of `StartSegmentDetection`.
    /// Within
    /// each segment type the array is sorted by timestamp values.
    segments: ?[]const SegmentDetection = null,

    /// An array containing the segment types requested in the call to
    /// `StartSegmentDetection`.
    selected_segment_types: ?[]const SegmentTypeInfo = null,

    /// If the job fails, `StatusMessage` provides a descriptive error message.
    status_message: ?[]const u8 = null,

    video: ?Video = null,

    /// Currently, Amazon Rekognition Video returns a single object in the
    /// `VideoMetadata` array. The object
    /// contains information about the video stream in the input file that Amazon
    /// Rekognition Video chose to analyze.
    /// The `VideoMetadata` object includes the video codec, video format and other
    /// information.
    /// Video metadata is returned in each page of information returned by
    /// `GetSegmentDetection`.
    video_metadata: ?[]const VideoMetadata = null,

    pub const json_field_names = .{
        .audio_metadata = "AudioMetadata",
        .job_id = "JobId",
        .job_status = "JobStatus",
        .job_tag = "JobTag",
        .next_token = "NextToken",
        .segments = "Segments",
        .selected_segment_types = "SelectedSegmentTypes",
        .status_message = "StatusMessage",
        .video = "Video",
        .video_metadata = "VideoMetadata",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSegmentDetectionInput, options: CallOptions) !GetSegmentDetectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSegmentDetectionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.GetSegmentDetection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSegmentDetectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetSegmentDetectionOutput, body, allocator);
}
