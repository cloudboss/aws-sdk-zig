const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DetectTextFilters = @import("detect_text_filters.zig").DetectTextFilters;
const Image = @import("image.zig").Image;
const TextDetection = @import("text_detection.zig").TextDetection;

pub const DetectTextInput = struct {
    /// Optional parameters that let you set the criteria that the text must meet to
    /// be included
    /// in your response.
    filters: ?DetectTextFilters = null,

    /// The input image as base64-encoded bytes or an Amazon S3 object. If you use
    /// the AWS
    /// CLI to call Amazon Rekognition operations, you can't pass image bytes.
    ///
    /// If you are using an AWS SDK to call Amazon Rekognition, you might not need
    /// to
    /// base64-encode image bytes passed using the `Bytes` field. For more
    /// information, see
    /// Images in the Amazon Rekognition developer guide.
    image: Image,

    pub const json_field_names = .{
        .filters = "Filters",
        .image = "Image",
    };
};

pub const DetectTextOutput = struct {
    /// An array of text that was detected in the input image.
    text_detections: ?[]const TextDetection = null,

    /// The model version used to detect text.
    text_model_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .text_detections = "TextDetections",
        .text_model_version = "TextModelVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetectTextInput, options: CallOptions) !DetectTextOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DetectTextInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.DetectText");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetectTextOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DetectTextOutput, body, allocator);
}
