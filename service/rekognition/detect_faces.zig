const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Attribute = @import("attribute.zig").Attribute;
const Image = @import("image.zig").Image;
const FaceDetail = @import("face_detail.zig").FaceDetail;
const OrientationCorrection = @import("orientation_correction.zig").OrientationCorrection;

pub const DetectFacesInput = struct {
    /// An array of facial attributes you want to be returned. A `DEFAULT` subset of
    /// facial attributes - `BoundingBox`, `Confidence`, `Pose`,
    /// `Quality`, and `Landmarks` - will always be returned. You can request
    /// for specific facial attributes (in addition to the default list) - by using
    /// [`"DEFAULT",
    /// "FACE_OCCLUDED"`] or just [`"FACE_OCCLUDED"`]. You can request for all
    /// facial attributes by using [`"ALL"]`. Requesting more attributes may
    /// increase
    /// response time.
    ///
    /// If you provide both, `["ALL", "DEFAULT"]`, the service uses a logical "AND"
    /// operator to determine which attributes to return (in this case, all
    /// attributes).
    ///
    /// Note that while the FaceOccluded and EyeDirection attributes are supported
    /// when using
    /// `DetectFaces`, they aren't supported when analyzing videos with
    /// `StartFaceDetection` and `GetFaceDetection`.
    attributes: ?[]const Attribute = null,

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

    pub const json_field_names = .{
        .attributes = "Attributes",
        .image = "Image",
    };
};

pub const DetectFacesOutput = struct {
    /// Details of each face found in the image.
    face_details: ?[]const FaceDetail = null,

    /// The value of `OrientationCorrection` is always null.
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
    orientation_correction: ?OrientationCorrection = null,

    pub const json_field_names = .{
        .face_details = "FaceDetails",
        .orientation_correction = "OrientationCorrection",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetectFacesInput, options: CallOptions) !DetectFacesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DetectFacesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.DetectFaces");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetectFacesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DetectFacesOutput, body, allocator);
}
