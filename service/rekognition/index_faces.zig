const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Attribute = @import("attribute.zig").Attribute;
const Image = @import("image.zig").Image;
const QualityFilter = @import("quality_filter.zig").QualityFilter;
const FaceRecord = @import("face_record.zig").FaceRecord;
const OrientationCorrection = @import("orientation_correction.zig").OrientationCorrection;
const UnindexedFace = @import("unindexed_face.zig").UnindexedFace;

pub const IndexFacesInput = struct {
    /// The ID of an existing collection to which you want to add the faces that are
    /// detected
    /// in the input images.
    collection_id: []const u8,

    /// An array of facial attributes you want to be returned. A `DEFAULT` subset of
    /// facial attributes - `BoundingBox`, `Confidence`, `Pose`,
    /// `Quality`, and `Landmarks` - will always be returned. You can request
    /// for specific facial attributes (in addition to the default list) - by using
    /// `["DEFAULT",
    /// "FACE_OCCLUDED"]` or just `["FACE_OCCLUDED"]`. You can request for all
    /// facial attributes by using `["ALL"]`. Requesting more attributes may
    /// increase
    /// response time.
    ///
    /// If you provide both, `["ALL", "DEFAULT"]`, the service uses a logical AND
    /// operator to determine which attributes to return (in this case, all
    /// attributes).
    detection_attributes: ?[]const Attribute = null,

    /// The ID you want to assign to all the faces detected in the image.
    external_image_id: ?[]const u8 = null,

    /// The input image as base64-encoded bytes or an S3 object. If you use the AWS
    /// CLI to
    /// call Amazon Rekognition operations, passing base64-encoded image bytes isn't
    /// supported.
    ///
    /// If you are using an AWS SDK to call Amazon Rekognition, you might not need
    /// to
    /// base64-encode image bytes passed using the `Bytes` field. For more
    /// information, see
    /// Images in the Amazon Rekognition developer guide.
    image: Image,

    /// The maximum number of faces to index. The value of `MaxFaces` must be
    /// greater
    /// than or equal to 1. `IndexFaces` returns no more than 100 detected faces in
    /// an
    /// image, even if you specify a larger value for `MaxFaces`.
    ///
    /// If `IndexFaces` detects more faces than the value of `MaxFaces`, the
    /// faces with the lowest quality are filtered out first. If there are still
    /// more faces than the
    /// value of `MaxFaces`, the faces with the smallest bounding boxes are filtered
    /// out
    /// (up to the number that's needed to satisfy the value of `MaxFaces`).
    /// Information
    /// about the unindexed faces is available in the `UnindexedFaces` array.
    ///
    /// The faces that are returned by `IndexFaces` are sorted by the largest face
    /// bounding box size to the smallest size, in descending order.
    ///
    /// `MaxFaces` can be used with a collection associated with any version of the
    /// face model.
    max_faces: ?i32 = null,

    /// A filter that specifies a quality bar for how much filtering is done to
    /// identify faces.
    /// Filtered faces aren't indexed. If you specify `AUTO`, Amazon Rekognition
    /// chooses the quality
    /// bar. If you specify `LOW`, `MEDIUM`, or `HIGH`, filtering
    /// removes all faces that don’t meet the chosen quality bar. The default value
    /// is
    /// `AUTO`.
    /// The quality bar is based on a variety of common use cases. Low-quality
    /// detections can occur
    /// for a number of reasons. Some examples are an object that's misidentified as
    /// a face, a face
    /// that's too blurry, or a face with a pose that's too extreme to use. If you
    /// specify
    /// `NONE`, no filtering is performed.
    ///
    /// To use quality filtering, the collection you are using must be associated
    /// with version 3
    /// of the face model or higher.
    quality_filter: ?QualityFilter = null,

    pub const json_field_names = .{
        .collection_id = "CollectionId",
        .detection_attributes = "DetectionAttributes",
        .external_image_id = "ExternalImageId",
        .image = "Image",
        .max_faces = "MaxFaces",
        .quality_filter = "QualityFilter",
    };
};

pub const IndexFacesOutput = struct {
    /// The version number of the face detection model that's associated with the
    /// input
    /// collection (`CollectionId`).
    face_model_version: ?[]const u8 = null,

    /// An array of faces detected and added to the collection. For more
    /// information,
    /// see Searching Faces in a Collection in the Amazon Rekognition Developer
    /// Guide.
    face_records: ?[]const FaceRecord = null,

    /// If your collection is associated with a face detection model that's later
    /// than version
    /// 3.0, the value of `OrientationCorrection` is always null and no orientation
    /// information is returned.
    ///
    /// If your collection is associated with a face detection model that's version
    /// 3.0 or
    /// earlier, the following applies:
    ///
    /// * If the input image is in .jpeg format, it might contain exchangeable image
    ///   file format
    /// (Exif) metadata that includes the image's orientation. Amazon Rekognition
    /// uses this orientation
    /// information to perform image correction - the bounding box coordinates are
    /// translated to
    /// represent object locations after the orientation information in the Exif
    /// metadata is used
    /// to correct the image orientation. Images in .png format don't contain Exif
    /// metadata. The
    /// value of `OrientationCorrection` is null.
    ///
    /// * If the image doesn't contain orientation information in its Exif metadata,
    ///   Amazon Rekognition
    /// returns an estimated orientation (ROTATE_0, ROTATE_90, ROTATE_180,
    /// ROTATE_270). Amazon Rekognition
    /// doesn’t perform image correction for images. The bounding box coordinates
    /// aren't
    /// translated and represent the object locations before the image is rotated.
    ///
    /// Bounding box information is returned in the `FaceRecords` array. You can get
    /// the version of the face detection model by calling DescribeCollection.
    orientation_correction: ?OrientationCorrection = null,

    /// An array of faces that were detected in the image but weren't indexed. They
    /// weren't
    /// indexed because the quality filter identified them as low quality, or the
    /// `MaxFaces` request parameter filtered them out. To use the quality filter,
    /// you
    /// specify the `QualityFilter` request parameter.
    unindexed_faces: ?[]const UnindexedFace = null,

    pub const json_field_names = .{
        .face_model_version = "FaceModelVersion",
        .face_records = "FaceRecords",
        .orientation_correction = "OrientationCorrection",
        .unindexed_faces = "UnindexedFaces",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: IndexFacesInput, options: CallOptions) !IndexFacesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: IndexFacesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.IndexFaces");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !IndexFacesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(IndexFacesOutput, body, allocator);
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
