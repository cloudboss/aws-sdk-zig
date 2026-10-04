const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LanguageCode = @import("language_code.zig").LanguageCode;
const TargetedSentimentEntity = @import("targeted_sentiment_entity.zig").TargetedSentimentEntity;

pub const DetectTargetedSentimentInput = struct {
    /// The language of the input documents. Currently, English is the only
    /// supported language.
    language_code: LanguageCode,

    /// A UTF-8 text string. The maximum string length is 5 KB.
    text: []const u8,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .text = "Text",
    };
};

pub const DetectTargetedSentimentOutput = struct {
    /// Targeted sentiment analysis for each of the entities identified in the input
    /// text.
    entities: ?[]const TargetedSentimentEntity = null,

    pub const json_field_names = .{
        .entities = "Entities",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetectTargetedSentimentInput, options: CallOptions) !DetectTargetedSentimentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DetectTargetedSentimentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.DetectTargetedSentiment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetectTargetedSentimentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DetectTargetedSentimentOutput, body, allocator);
}
