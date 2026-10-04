const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DocumentOutputFormat = @import("document_output_format.zig").DocumentOutputFormat;
const UserContext = @import("user_context.zig").UserContext;

pub const GetDocumentContentInput = struct {
    /// The unique identifier of the data source that contains the document.
    data_source_id: []const u8,

    /// The unique identifier of the document to retrieve content for.
    document_id: []const u8,

    /// The unique identifier of the knowledge base that contains the document.
    knowledge_base_id: []const u8,

    /// The output format for the document content. `RAW` returns the original file.
    /// `EXTRACTED` returns parsed text as JSON. Defaults to `RAW`.
    output_format: ?DocumentOutputFormat = null,

    /// Contains information about the user making the request. This is used for
    /// access control filtering to ensure that results only include documents the
    /// user is authorized to access.
    user_context: ?UserContext = null,

    pub const json_field_names = .{
        .data_source_id = "dataSourceId",
        .document_id = "documentId",
        .knowledge_base_id = "knowledgeBaseId",
        .output_format = "outputFormat",
        .user_context = "userContext",
    };
};

pub const GetDocumentContentOutput = struct {
    /// The size of the document content in bytes available at the pre-signed URL.
    document_content_length: ?i64 = null,

    /// The MIME type of the document content. For `RAW` format, this is the
    /// original file type (for example, `application/pdf`). For `EXTRACTED` format,
    /// this is always `application/json`.
    mime_type: []const u8,

    /// A pre-signed URL for downloading the document content. The URL expires after
    /// 5 minutes.
    presigned_url: []const u8,

    pub const json_field_names = .{
        .document_content_length = "documentContentLength",
        .mime_type = "mimeType",
        .presigned_url = "presignedUrl",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDocumentContentInput, options: CallOptions) !GetDocumentContentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDocumentContentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent-runtime", "Bedrock Agent Runtime", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgebases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/datasources/");
    try path_buf.appendSlice(allocator, input.data_source_id);
    try path_buf.appendSlice(allocator, "/documents/");
    try path_buf.appendSlice(allocator, input.document_id);
    try path_buf.appendSlice(allocator, "/content");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.output_format) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"outputFormat\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.user_context) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"userContext\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDocumentContentOutput {
    const result: GetDocumentContentOutput = try aws.json.parseJsonObject(
        GetDocumentContentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
