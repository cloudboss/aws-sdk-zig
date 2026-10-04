const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DetectLabelsFeatureName = @import("detect_labels_feature_name.zig").DetectLabelsFeatureName;
const Image = @import("image.zig").Image;
const DetectLabelsSettings = @import("detect_labels_settings.zig").DetectLabelsSettings;
const DetectLabelsImageProperties = @import("detect_labels_image_properties.zig").DetectLabelsImageProperties;
const Label = @import("label.zig").Label;
const OrientationCorrection = @import("orientation_correction.zig").OrientationCorrection;

pub const DetectLabelsInput = struct {
    /// A list of the types of analysis to perform. Specifying GENERAL_LABELS uses
    /// the label
    /// detection feature, while specifying IMAGE_PROPERTIES returns information
    /// regarding image color
    /// and quality. If no option is specified GENERAL_LABELS is used by default.
    features: ?[]const DetectLabelsFeatureName = null,

    /// The input image as base64-encoded bytes or an S3 object. If you use the AWS
    /// CLI to
    /// call Amazon Rekognition operations, passing image bytes is not supported.
    /// Images stored in an
    /// S3 Bucket do not need to be base64-encoded.
    ///
    /// If you are using an AWS SDK to call Amazon Rekognition, you might not need
    /// to
    /// base64-encode image bytes passed using the `Bytes` field. For more
    /// information, see
    /// Images in the Amazon Rekognition developer guide.
    image: Image,

    /// Maximum number of labels you want the service to return in the response. The
    /// service
    /// returns the specified number of highest confidence labels. Only valid when
    /// GENERAL_LABELS is
    /// specified as a feature type in the Feature input parameter.
    max_labels: ?i32 = null,

    /// Specifies the minimum confidence level for the labels to return. Amazon
    /// Rekognition doesn't
    /// return any labels with confidence lower than this specified value.
    ///
    /// If `MinConfidence` is not specified, the operation returns labels with a
    /// confidence values greater than or equal to 55 percent. Only valid when
    /// GENERAL_LABELS is
    /// specified as a feature type in the Feature input parameter.
    min_confidence: ?f32 = null,

    /// A list of the filters to be applied to returned detected labels and image
    /// properties.
    /// Specified filters can be inclusive, exclusive, or a combination of both.
    /// Filters can be used
    /// for individual labels or label categories. The exact label names or label
    /// categories must be
    /// supplied. For a full list of labels and label categories, see [Detecting
    /// labels](https://docs.aws.amazon.com/rekognition/latest/dg/labels.html).
    settings: ?DetectLabelsSettings = null,

    pub const json_field_names = .{
        .features = "Features",
        .image = "Image",
        .max_labels = "MaxLabels",
        .min_confidence = "MinConfidence",
        .settings = "Settings",
    };
};

pub const DetectLabelsOutput = struct {
    /// Information about the properties of the input image, such as brightness,
    /// sharpness,
    /// contrast, and dominant colors.
    image_properties: ?DetectLabelsImageProperties = null,

    /// Version number of the label detection model that was used to detect labels.
    label_model_version: ?[]const u8 = null,

    /// An array of labels for the real-world objects detected.
    labels: ?[]const Label = null,

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
        .image_properties = "ImageProperties",
        .label_model_version = "LabelModelVersion",
        .labels = "Labels",
        .orientation_correction = "OrientationCorrection",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetectLabelsInput, options: CallOptions) !DetectLabelsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DetectLabelsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.DetectLabels");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetectLabelsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DetectLabelsOutput, body, allocator);
}
