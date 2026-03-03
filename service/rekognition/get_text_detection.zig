const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTextDetectionInput, options: Options) !GetTextDetectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "rekognition");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetTextDetectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rekognition", "Rekognition", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "HumanLoopQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .human_loop_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IdempotentParameterMismatchException")) {
        return .{ .arena = arena, .kind = .{ .idempotent_parameter_mismatch_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ImageTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .image_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidImageFormatException")) {
        return .{ .arena = arena, .kind = .{ .invalid_image_format_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidManifestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_manifest_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPaginationTokenException")) {
        return .{ .arena = arena, .kind = .{ .invalid_pagination_token_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidParameterException")) {
        return .{ .arena = arena, .kind = .{ .invalid_parameter_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyRevisionIdException")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_revision_id_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidS3ObjectException")) {
        return .{ .arena = arena, .kind = .{ .invalid_s3_object_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MalformedPolicyDocumentException")) {
        return .{ .arena = arena, .kind = .{ .malformed_policy_document_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ProvisionedThroughputExceededException")) {
        return .{ .arena = arena, .kind = .{ .provisioned_throughput_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistsException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exists_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotReadyException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_ready_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SessionNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .session_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "VideoTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .video_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
