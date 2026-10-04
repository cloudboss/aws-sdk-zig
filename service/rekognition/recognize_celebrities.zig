const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Image = @import("image.zig").Image;
const Celebrity = @import("celebrity.zig").Celebrity;
const OrientationCorrection = @import("orientation_correction.zig").OrientationCorrection;
const ComparedFace = @import("compared_face.zig").ComparedFace;

pub const RecognizeCelebritiesInput = struct {
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
        .image = "Image",
    };
};

pub const RecognizeCelebritiesOutput = struct {
    /// Details about each celebrity found in the image. Amazon Rekognition can
    /// detect a maximum of 64
    /// celebrities in an image. Each celebrity object includes the following
    /// attributes:
    /// `Face`, `Confidence`, `Emotions`, `Landmarks`,
    /// `Pose`, `Quality`, `Smile`, `Id`,
    /// `KnownGender`, `MatchConfidence`, `Name`,
    /// `Urls`.
    celebrity_faces: ?[]const Celebrity = null,

    /// Support for estimating image orientation using the the OrientationCorrection
    /// field
    /// has ceased as of August 2021. Any returned values for this field included in
    /// an API response
    /// will always be NULL.
    ///
    /// The orientation of the input image (counterclockwise direction). If your
    /// application
    /// displays the image, you can use this value to correct the orientation. The
    /// bounding box
    /// coordinates returned in `CelebrityFaces` and `UnrecognizedFaces`
    /// represent face locations before the image orientation is corrected.
    ///
    /// If the input image is in .jpeg format, it might contain exchangeable image
    /// (Exif)
    /// metadata that includes the image's orientation. If so, and the Exif metadata
    /// for the input
    /// image populates the orientation field, the value of `OrientationCorrection`
    /// is
    /// null. The `CelebrityFaces` and `UnrecognizedFaces` bounding box
    /// coordinates represent face locations after Exif metadata is used to correct
    /// the image
    /// orientation. Images in .png format don't contain Exif metadata.
    orientation_correction: ?OrientationCorrection = null,

    /// Details about each unrecognized face in the image.
    unrecognized_faces: ?[]const ComparedFace = null,

    pub const json_field_names = .{
        .celebrity_faces = "CelebrityFaces",
        .orientation_correction = "OrientationCorrection",
        .unrecognized_faces = "UnrecognizedFaces",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RecognizeCelebritiesInput, options: CallOptions) !RecognizeCelebritiesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RecognizeCelebritiesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.RecognizeCelebrities");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RecognizeCelebritiesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RecognizeCelebritiesOutput, body, allocator);
}
