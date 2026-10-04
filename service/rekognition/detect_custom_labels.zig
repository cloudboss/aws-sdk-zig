const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Image = @import("image.zig").Image;
const CustomLabel = @import("custom_label.zig").CustomLabel;

pub const DetectCustomLabelsInput = struct {
    image: Image,

    /// Maximum number of results you want the service to return in the response.
    /// The service returns the specified number of highest confidence labels ranked
    /// from highest confidence
    /// to lowest.
    max_results: ?i32 = null,

    /// Specifies the minimum confidence level for the labels to return.
    /// `DetectCustomLabels` doesn't return any labels with a confidence value
    /// that's lower than
    /// this specified value. If you specify a
    /// value of 0, `DetectCustomLabels` returns all labels, regardless of the
    /// assumed
    /// threshold applied to each label.
    /// If you don't specify a value for `MinConfidence`, `DetectCustomLabels`
    /// returns labels based on the assumed threshold of each label.
    min_confidence: ?f32 = null,

    /// The ARN of the model version that you want to use. Only models associated
    /// with Custom
    /// Labels projects accepted by the operation. If a provided ARN refers to a
    /// model version
    /// associated with a project for a different feature type, then an
    /// InvalidParameterException
    /// is returned.
    project_version_arn: []const u8,

    pub const json_field_names = .{
        .image = "Image",
        .max_results = "MaxResults",
        .min_confidence = "MinConfidence",
        .project_version_arn = "ProjectVersionArn",
    };
};

pub const DetectCustomLabelsOutput = struct {
    /// An array of custom labels detected in the input image.
    custom_labels: ?[]const CustomLabel = null,

    pub const json_field_names = .{
        .custom_labels = "CustomLabels",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetectCustomLabelsInput, options: CallOptions) !DetectCustomLabelsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DetectCustomLabelsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.DetectCustomLabels");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetectCustomLabelsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DetectCustomLabelsOutput, body, allocator);
}
