const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FaceSearchSortBy = @import("face_search_sort_by.zig").FaceSearchSortBy;
const VideoJobStatus = @import("video_job_status.zig").VideoJobStatus;
const PersonMatch = @import("person_match.zig").PersonMatch;
const Video = @import("video.zig").Video;
const VideoMetadata = @import("video_metadata.zig").VideoMetadata;

pub const GetFaceSearchInput = struct {
    /// The job identifer for the search request. You get the job identifier from an
    /// initial call to `StartFaceSearch`.
    job_id: []const u8,

    /// Maximum number of results to return per paginated call. The largest value
    /// you can specify is 1000.
    /// If you specify a value greater than 1000, a maximum of 1000 results is
    /// returned.
    /// The default value is 1000.
    max_results: ?i32 = null,

    /// If the previous response was incomplete (because there is more search
    /// results to retrieve), Amazon Rekognition Video returns a pagination
    /// token in the response. You can use this pagination token to retrieve the
    /// next set of search results.
    next_token: ?[]const u8 = null,

    /// Sort to use for grouping faces in the response. Use `TIMESTAMP` to group
    /// faces by the time
    /// that they are recognized. Use `INDEX` to sort by recognized faces.
    sort_by: ?FaceSearchSortBy = null,

    pub const json_field_names = .{
        .job_id = "JobId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_by = "SortBy",
    };
};

pub const GetFaceSearchOutput = struct {
    /// Job identifier for the face search operation for which you want to obtain
    /// results. The job
    /// identifer is returned by an initial call to StartFaceSearch.
    job_id: ?[]const u8 = null,

    /// The current status of the face search job.
    job_status: ?VideoJobStatus = null,

    /// A job identifier specified in the call to StartFaceSearch and returned in
    /// the job
    /// completion notification sent to your Amazon Simple Notification Service
    /// topic.
    job_tag: ?[]const u8 = null,

    /// If the response is truncated, Amazon Rekognition Video returns this token
    /// that you can use in the subsequent request to retrieve the next set of
    /// search results.
    next_token: ?[]const u8 = null,

    /// An array of persons, PersonMatch,
    /// in the video whose face(s) match the face(s) in an Amazon Rekognition
    /// collection. It also includes time information
    /// for when persons are matched in the video.
    /// You specify the input collection in an initial call to `StartFaceSearch`.
    /// Each `Persons` element includes a time the person was matched,
    /// face match details (`FaceMatches`) for matching faces in the collection,
    /// and person information (`Person`) for the matched person.
    persons: ?[]const PersonMatch = null,

    /// If the job fails, `StatusMessage` provides a descriptive error message.
    status_message: ?[]const u8 = null,

    video: ?Video = null,

    /// Information about a video that Amazon Rekognition analyzed. `Videometadata`
    /// is returned in every page of paginated responses
    /// from a Amazon Rekognition Video operation.
    video_metadata: ?VideoMetadata = null,

    pub const json_field_names = .{
        .job_id = "JobId",
        .job_status = "JobStatus",
        .job_tag = "JobTag",
        .next_token = "NextToken",
        .persons = "Persons",
        .status_message = "StatusMessage",
        .video = "Video",
        .video_metadata = "VideoMetadata",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetFaceSearchInput, options: CallOptions) !GetFaceSearchOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetFaceSearchInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.GetFaceSearch");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetFaceSearchOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetFaceSearchOutput, body, allocator);
}
