const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DominantLanguage = @import("dominant_language.zig").DominantLanguage;

pub const DetectDominantLanguageInput = struct {
    /// A UTF-8 text string. The string must contain at least 20 characters. The
    /// maximum string size is 100 KB.
    text: []const u8,

    pub const json_field_names = .{
        .text = "Text",
    };
};

pub const DetectDominantLanguageOutput = struct {
    /// Array of languages that Amazon Comprehend detected in the input text.
    /// The array is sorted in descending order of the score
    /// (the dominant language is always the first element in the array).
    ///
    /// For each language, the
    /// response returns the RFC 5646 language code and the level of confidence that
    /// Amazon Comprehend
    /// has in the accuracy of its inference. For more information about RFC 5646,
    /// see [Tags for Identifying Languages](https://tools.ietf.org/html/rfc5646) on
    /// the
    /// *IETF Tools* web site.
    languages: ?[]const DominantLanguage = null,

    pub const json_field_names = .{
        .languages = "Languages",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetectDominantLanguageInput, options: CallOptions) !DetectDominantLanguageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DetectDominantLanguageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.DetectDominantLanguage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetectDominantLanguageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DetectDominantLanguageOutput, body, allocator);
}
