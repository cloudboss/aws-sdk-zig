const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SyntaxLanguageCode = @import("syntax_language_code.zig").SyntaxLanguageCode;
const SyntaxToken = @import("syntax_token.zig").SyntaxToken;

pub const DetectSyntaxInput = struct {
    /// The language code of the input documents. You can specify any of the
    /// following languages
    /// supported by Amazon Comprehend: German ("de"), English ("en"), Spanish
    /// ("es"), French ("fr"),
    /// Italian ("it"), or Portuguese ("pt").
    language_code: SyntaxLanguageCode,

    /// A UTF-8 string. The maximum string size is 5 KB.
    text: []const u8,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .text = "Text",
    };
};

pub const DetectSyntaxOutput = struct {
    /// A collection of syntax tokens describing the text. For each token, the
    /// response provides
    /// the text, the token type, where the text begins and ends, and the level of
    /// confidence that
    /// Amazon Comprehend has that the token is correct. For a list of token types,
    /// see
    /// [Syntax](https://docs.aws.amazon.com/comprehend/latest/dg/how-syntax.html)
    /// in the Comprehend Developer Guide.
    syntax_tokens: ?[]const SyntaxToken = null,

    pub const json_field_names = .{
        .syntax_tokens = "SyntaxTokens",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetectSyntaxInput, options: CallOptions) !DetectSyntaxOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DetectSyntaxInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.DetectSyntax");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetectSyntaxOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DetectSyntaxOutput, body, allocator);
}
