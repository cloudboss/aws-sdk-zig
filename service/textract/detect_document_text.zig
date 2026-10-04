const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Document = @import("document.zig").Document;
const Block = @import("block.zig").Block;
const DocumentMetadata = @import("document_metadata.zig").DocumentMetadata;

pub const DetectDocumentTextInput = struct {
    /// The input document as base64-encoded bytes or an Amazon S3 object. If you
    /// use the AWS CLI
    /// to call Amazon Textract operations, you can't pass image bytes. The document
    /// must be an image
    /// in JPEG or PNG format.
    ///
    /// If you're using an AWS SDK to call Amazon Textract, you might not need to
    /// base64-encode
    /// image bytes that are passed using the `Bytes` field.
    document: Document,

    pub const json_field_names = .{
        .document = "Document",
    };
};

pub const DetectDocumentTextOutput = struct {
    /// An array of `Block` objects that contain the text that's detected in the
    /// document.
    blocks: ?[]const Block = null,

    detect_document_text_model_version: ?[]const u8 = null,

    /// Metadata about the document. It contains the number of pages that are
    /// detected in the
    /// document.
    document_metadata: ?DocumentMetadata = null,

    pub const json_field_names = .{
        .blocks = "Blocks",
        .detect_document_text_model_version = "DetectDocumentTextModelVersion",
        .document_metadata = "DocumentMetadata",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DetectDocumentTextInput, options: CallOptions) !DetectDocumentTextOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "textract", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DetectDocumentTextInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("textract", "Textract", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Textract.DetectDocumentText");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DetectDocumentTextOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DetectDocumentTextOutput, body, allocator);
}
