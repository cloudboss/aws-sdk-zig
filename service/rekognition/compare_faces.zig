const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CompareFacesInput, options: CallOptions) !CompareFacesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CompareFacesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.CompareFaces");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CompareFacesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CompareFacesOutput, body, allocator);
}
