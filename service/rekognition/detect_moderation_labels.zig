const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HumanLoopConfig = @import("human_loop_config.zig").HumanLoopConfig;
const Image = @import("image.zig").Image;
const ContentType = @import("content_type.zig").ContentType;
const HumanLoopActivationOutput = @import("human_loop_activation_output.zig").HumanLoopActivationOutput;
const ModerationLabel = @import("moderation_label.zig").ModerationLabel;

pub const DetectModerationLabelsInput = struct {
    /// Sets up the configuration for human evaluation, including the FlowDefinition
    /// the image
    /// will be sent to.
    human_loop_config: ?HumanLoopConfig = null,

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

    /// Specifies the minimum confidence level for the labels to return. Amazon
    /// Rekognition doesn't
    /// return any labels with a confidence level lower than this specified value.
    ///
    /// If you don't specify `MinConfidence`, the operation returns labels with
    /// confidence values greater than or equal to 50 percent.
    min_confidence: ?f32 = null,

    /// Identifier for the custom adapter. Expects the ProjectVersionArn as a value.
    /// Use the CreateProject or CreateProjectVersion APIs to create a custom
    /// adapter.
    project_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .human_loop_config = "HumanLoopConfig",
        .image = "Image",
        .min_confidence = "MinConfidence",
        .project_version = "ProjectVersion",
    };
};

pub const DetectModerationLabelsOutput = struct {
    /// A list of predicted results for the type of content an image contains. For
    /// example,
    /// the image content might be from animation, sports, or a video game.
    content_types: ?[]const ContentType = null,

    /// Shows the results of the human in the loop evaluation.
    human_loop_activation_output: ?HumanLoopActivationOutput = null,

    /// Array of detected Moderation labels. For video operations, this includes the
    /// time,
    /// in milliseconds from the start of the video, they were detected.
    moderation_labels: ?[]const ModerationLabel = null,

    /// Version number of the base moderation detection model that was used to
    /// detect unsafe
    /// content.
    moderation_model_version: ?[]const u8 = null,

    /// Identifier of the custom adapter that was used during inference. If
    /// during inference the adapter was EXPIRED, then the parameter will not be
    /// returned,
    /// indicating that a base moderation detection project version was used.
    project_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .content_types = "ContentTypes",
        .human_loop_activation_output = "HumanLoopActivationOutput",
        .moderation_labels = "ModerationLabels",
        .moderation_model_version = "ModerationModelVersion",
        .project_version = "ProjectVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetectModerationLabelsInput, options: CallOptions) !DetectModerationLabelsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DetectModerationLabelsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "RekognitionService.DetectModerationLabels");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetectModerationLabelsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DetectModerationLabelsOutput, body, allocator);
}
