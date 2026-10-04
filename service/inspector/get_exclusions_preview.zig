const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Locale = @import("locale.zig").Locale;
const ExclusionPreview = @import("exclusion_preview.zig").ExclusionPreview;
const PreviewStatus = @import("preview_status.zig").PreviewStatus;

pub const GetExclusionsPreviewInput = struct {
    /// The ARN that specifies the assessment template for which the exclusions
    /// preview was
    /// requested.
    assessment_template_arn: []const u8,

    /// The locale into which you want to translate the exclusion's title,
    /// description, and
    /// recommendation.
    locale: ?Locale = null,

    /// You can use this parameter to indicate the maximum number of items you want
    /// in the
    /// response. The default value is 100. The maximum value is 500.
    max_results: ?i32 = null,

    /// You can use this parameter when paginating results. Set the value of this
    /// parameter
    /// to null on your first call to the GetExclusionsPreviewRequest action.
    /// Subsequent calls to
    /// the action fill nextToken in the request with the value of nextToken from
    /// the previous
    /// response to continue listing data.
    next_token: ?[]const u8 = null,

    /// The unique identifier associated of the exclusions preview.
    preview_token: []const u8,

    pub const json_field_names = .{
        .assessment_template_arn = "assessmentTemplateArn",
        .locale = "locale",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .preview_token = "previewToken",
    };
};

pub const GetExclusionsPreviewOutput = struct {
    /// Information about the exclusions included in the preview.
    exclusion_previews: ?[]const ExclusionPreview = null,

    /// When a response is generated, if there is more data to be listed, this
    /// parameters is
    /// present in the response and contains the value to use for the nextToken
    /// parameter in a
    /// subsequent pagination request. If there is no more data to be listed, this
    /// parameter is set
    /// to null.
    next_token: ?[]const u8 = null,

    /// Specifies the status of the request to generate an exclusions preview.
    preview_status: PreviewStatus,

    pub const json_field_names = .{
        .exclusion_previews = "exclusionPreviews",
        .next_token = "nextToken",
        .preview_status = "previewStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetExclusionsPreviewInput, options: CallOptions) !GetExclusionsPreviewOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetExclusionsPreviewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector", "Inspector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "InspectorService.GetExclusionsPreview");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetExclusionsPreviewOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetExclusionsPreviewOutput, body, allocator);
}
