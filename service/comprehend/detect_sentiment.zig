const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LanguageCode = @import("language_code.zig").LanguageCode;
const SentimentType = @import("sentiment_type.zig").SentimentType;
const SentimentScore = @import("sentiment_score.zig").SentimentScore;

pub const DetectSentimentInput = struct {
    /// The language of the input documents. You can specify any of the primary
    /// languages
    /// supported by Amazon Comprehend. All documents must be in the same language.
    language_code: LanguageCode,

    /// A UTF-8 text string. The maximum string size is 5 KB.
    text: []const u8,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .text = "Text",
    };
};

pub const DetectSentimentOutput = struct {
    /// The inferred sentiment that Amazon Comprehend has the highest level of
    /// confidence
    /// in.
    sentiment: ?SentimentType = null,

    /// An object that lists the sentiments, and their corresponding confidence
    /// levels.
    sentiment_score: ?SentimentScore = null,

    pub const json_field_names = .{
        .sentiment = "Sentiment",
        .sentiment_score = "SentimentScore",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetectSentimentInput, options: CallOptions) !DetectSentimentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DetectSentimentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.DetectSentiment");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetectSentimentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DetectSentimentOutput, body, allocator);
}
