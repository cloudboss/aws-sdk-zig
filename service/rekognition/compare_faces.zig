const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const QualityFilter = @import("quality_filter.zig").QualityFilter;
const Image = @import("image.zig").Image;
const CompareFacesMatch = @import("compare_faces_match.zig").CompareFacesMatch;
const ComparedSourceImageFace = @import("compared_source_image_face.zig").ComparedSourceImageFace;
const OrientationCorrection = @import("orientation_correction.zig").OrientationCorrection;
const ComparedFace = @import("compared_face.zig").ComparedFace;

pub const CompareFacesInput = struct {
    /// A filter that specifies a quality bar for how much filtering is done to
    /// identify faces.
    /// Filtered faces aren't compared. If you specify `AUTO`, Amazon Rekognition
    /// chooses the
    /// quality bar. If you specify `LOW`, `MEDIUM`, or `HIGH`,
    /// filtering removes all faces that don’t meet the chosen quality bar.
    /// The quality bar is
    /// based on a variety of common use cases. Low-quality detections can occur for
    /// a number of
    /// reasons. Some examples are an object that's misidentified as a face, a face
    /// that's too blurry,
    /// or a face with a pose that's too extreme to use. If you specify `NONE`, no
    /// filtering is performed. The default value is `NONE`.
    ///
    /// To use quality filtering, the collection you are using must be associated
    /// with version 3
    /// of the face model or higher.
    quality_filter: ?QualityFilter = null,

    /// The minimum level of confidence in the face matches that a match must meet
    /// to be
    /// included in the `FaceMatches` array.
    similarity_threshold: ?f32 = null,

    /// The input image as base64-encoded bytes or an S3 object. If you use the AWS
    /// CLI to
    /// call Amazon Rekognition operations, passing base64-encoded image bytes is
    /// not supported.
    ///
    /// If you are using an AWS SDK to call Amazon Rekognition, you might not need
    /// to
    /// base64-encode image bytes passed using the `Bytes` field. For more
    /// information, see
    /// Images in the Amazon Rekognition developer guide.
    source_image: Image,

    /// The target image as base64-encoded bytes or an S3 object. If you use the AWS
    /// CLI to
    /// call Amazon Rekognition operations, passing base64-encoded image bytes is
    /// not supported.
    ///
    /// If you are using an AWS SDK to call Amazon Rekognition, you might not need
    /// to
    /// base64-encode image bytes passed using the `Bytes` field. For more
    /// information, see
    /// Images in the Amazon Rekognition developer guide.
    target_image: Image,

    pub const json_field_names = .{
        .quality_filter = "QualityFilter",
        .similarity_threshold = "SimilarityThreshold",
        .source_image = "SourceImage",
        .target_image = "TargetImage",
    };
};

pub const CompareFacesOutput = struct {
    /// An array of faces in the target image that match the source image face. Each
    /// `CompareFacesMatch` object provides the bounding box, the confidence level
    /// that
    /// the bounding box contains a face, and the similarity score for the face in
    /// the bounding box
    /// and the face in the source image.
    face_matches: ?[]const CompareFacesMatch = null,

    /// The face in the source image that was used for comparison.
    source_image_face: ?ComparedSourceImageFace = null,

    /// The value of `SourceImageOrientationCorrection` is always null.
    ///
    /// If the input image is in .jpeg format, it might contain exchangeable image
    /// file format
    /// (Exif) metadata that includes the image's orientation. Amazon Rekognition
    /// uses this orientation
    /// information to perform image correction. The bounding box coordinates are
    /// translated to
    /// represent object locations after the orientation information in the Exif
    /// metadata is used to
    /// correct the image orientation. Images in .png format don't contain Exif
    /// metadata.
    ///
    /// Amazon Rekognition doesn’t perform image correction for images in .png
    /// format and .jpeg images
    /// without orientation information in the image Exif metadata. The bounding box
    /// coordinates
    /// aren't translated and represent the object locations before the image is
    /// rotated.
    source_image_orientation_correction: ?OrientationCorrection = null,

    /// The value of `TargetImageOrientationCorrection` is always null.
    ///
    /// If the input image is in .jpeg format, it might contain exchangeable image
    /// file format
    /// (Exif) metadata that includes the image's orientation. Amazon Rekognition
    /// uses this orientation
    /// information to perform image correction. The bounding box coordinates are
    /// translated to
    /// represent object locations after the orientation information in the Exif
    /// metadata is used to
    /// correct the image orientation. Images in .png format don't contain Exif
    /// metadata.
    ///
    /// Amazon Rekognition doesn’t perform image correction for images in .png
    /// format and .jpeg images
    /// without orientation information in the image Exif metadata. The bounding box
    /// coordinates
    /// aren't translated and represent the object locations before the image is
    /// rotated.
    target_image_orientation_correction: ?OrientationCorrection = null,

    /// An array of faces in the target image that did not match the source image
    /// face.
    unmatched_faces: ?[]const ComparedFace = null,

    pub const json_field_names = .{
        .face_matches = "FaceMatches",
        .source_image_face = "SourceImageFace",
        .source_image_orientation_correction = "SourceImageOrientationCorrection",
        .target_image_orientation_correction = "TargetImageOrientationCorrection",
        .unmatched_faces = "UnmatchedFaces",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CompareFacesInput, options: Options) !CompareFacesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CompareFacesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.CompareFaces");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CompareFacesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CompareFacesOutput, body, allocator);
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
