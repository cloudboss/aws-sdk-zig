const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SyntaxLanguageCode = @import("syntax_language_code.zig").SyntaxLanguageCode;
const BatchItemError = @import("batch_item_error.zig").BatchItemError;
const BatchDetectSyntaxItemResult = @import("batch_detect_syntax_item_result.zig").BatchDetectSyntaxItemResult;

pub const BatchDetectSyntaxInput = struct {
    /// The language of the input documents. You can specify any of the following
    /// languages
    /// supported by Amazon Comprehend: German ("de"), English ("en"), Spanish
    /// ("es"), French ("fr"),
    /// Italian ("it"), or Portuguese ("pt"). All documents must be in the same
    /// language.
    language_code: SyntaxLanguageCode,

    /// A list containing the UTF-8 encoded text of the input documents. The list
    /// can contain a maximum of 25
    /// documents. The maximum size for each document is 5 KB.
    text_list: []const []const u8,

    pub const json_field_names = .{
        .language_code = "LanguageCode",
        .text_list = "TextList",
    };
};

pub const BatchDetectSyntaxOutput = struct {
    /// A list containing one object for each document that
    /// contained an error. The results are sorted in ascending order by the `Index`
    /// field
    /// and match the order of the documents in the input list. If there are no
    /// errors in the batch,
    /// the `ErrorList` is empty.
    error_list: ?[]const BatchItemError = null,

    /// A list of objects containing the
    /// results of the operation. The results are sorted in ascending order by the
    /// `Index`
    /// field and match the order of the documents in the input list. If all of the
    /// documents contain
    /// an error, the `ResultList` is empty.
    result_list: ?[]const BatchDetectSyntaxItemResult = null,

    pub const json_field_names = .{
        .error_list = "ErrorList",
        .result_list = "ResultList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDetectSyntaxInput, options: CallOptions) !BatchDetectSyntaxOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDetectSyntaxInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Comprehend_20171127.BatchDetectSyntax");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDetectSyntaxOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(BatchDetectSyntaxOutput, body, allocator);
}
