const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LanguageCode = @import("language_code.zig").LanguageCode;
const TextSegment = @import("text_segment.zig").TextSegment;
const ToxicLabels = @import("toxic_labels.zig").ToxicLabels;

pub const DetectToxicContentInput = struct {
    /// The language of the input text. Currently, English is the only supported
    /// language.
    language_code: LanguageCode,

    /// A list of up to 10 text strings. Each string has a maximum size of 1 KB, and
    /// the maximum size of the list is 10 KB.
    text_segments: []const TextSegment,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .text_segments = "TextSegments",
    };
};

pub const DetectToxicContentOutput = struct {
    /// Results of the content moderation analysis.
    /// Each entry in the results list contains a list of toxic content types
    /// identified in
    /// the text, along with a confidence score for each content type.
    /// The results list also includes a toxicity score for each entry in the
    /// results list.
    result_list: ?[]const ToxicLabels = null,

    pub const json_field_names = .{
        .result_list = "ResultList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetectToxicContentInput, options: CallOptions) !DetectToxicContentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "comprehend", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DetectToxicContentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("comprehend", "Comprehend", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.DetectToxicContent");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetectToxicContentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DetectToxicContentOutput, body, allocator);
}
