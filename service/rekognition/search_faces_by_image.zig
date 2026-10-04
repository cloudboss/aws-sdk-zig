const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Image = @import("image.zig").Image;
const QualityFilter = @import("quality_filter.zig").QualityFilter;
const FaceMatch = @import("face_match.zig").FaceMatch;
const BoundingBox = @import("bounding_box.zig").BoundingBox;

pub const SearchFacesByImageInput = struct {
    /// ID of the collection to search.
    collection_id: []const u8,

    /// (Optional) Specifies the minimum confidence in the face match to return. For
    /// example,
    /// don't return any matches where confidence in matches is less than 70%. The
    /// default value is
    /// 80%.
    face_match_threshold: ?f32 = null,

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
    image: Image,

    /// Maximum number of faces to return. The operation returns the maximum number
    /// of faces
    /// with the highest confidence in the match.
    max_faces: ?i32 = null,

    /// A filter that specifies a quality bar for how much filtering is done to
    /// identify faces.
    /// Filtered faces aren't searched for in the collection. If you specify `AUTO`,
    /// Amazon Rekognition chooses the quality bar. If you specify `LOW`, `MEDIUM`,
    /// or
    /// `HIGH`, filtering removes all faces that don’t meet the chosen quality bar.
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

    pub const json_field_names = .{
        .collection_id = "CollectionId",
        .face_match_threshold = "FaceMatchThreshold",
        .image = "Image",
        .max_faces = "MaxFaces",
        .quality_filter = "QualityFilter",
    };
};

pub const SearchFacesByImageOutput = struct {
    /// An array of faces that match the input face, along with the confidence in
    /// the
    /// match.
    face_matches: ?[]const FaceMatch = null,

    /// Version number of the face detection model associated with the input
    /// collection
    /// (`CollectionId`).
    face_model_version: ?[]const u8 = null,

    /// The bounding box around the face in the input image that Amazon Rekognition
    /// used for the
    /// search.
    searched_face_bounding_box: ?BoundingBox = null,

    /// The level of confidence that the `searchedFaceBoundingBox`, contains a
    /// face.
    searched_face_confidence: ?f32 = null,

    pub const json_field_names = .{
        .face_matches = "FaceMatches",
        .face_model_version = "FaceModelVersion",
        .searched_face_bounding_box = "SearchedFaceBoundingBox",
        .searched_face_confidence = "SearchedFaceConfidence",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SearchFacesByImageInput, options: CallOptions) !SearchFacesByImageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SearchFacesByImageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.SearchFacesByImage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SearchFacesByImageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(SearchFacesByImageOutput, body, allocator);
}
