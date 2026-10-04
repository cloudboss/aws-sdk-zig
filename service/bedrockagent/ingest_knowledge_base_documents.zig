const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const KnowledgeBaseDocument = @import("knowledge_base_document.zig").KnowledgeBaseDocument;
const KnowledgeBaseDocumentDetail = @import("knowledge_base_document_detail.zig").KnowledgeBaseDocumentDetail;

pub const IngestKnowledgeBaseDocumentsInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, Amazon
    /// Bedrock ignores the request, but does not return an error. For more
    /// information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The unique identifier of the data source connected to the knowledge base
    /// that you're adding documents to.
    data_source_id: []const u8,

    /// A list of objects, each of which contains information about the documents to
    /// add.
    documents: []const KnowledgeBaseDocument,

    /// The unique identifier of the knowledge base to ingest the documents into.
    knowledge_base_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .data_source_id = "dataSourceId",
        .documents = "documents",
        .knowledge_base_id = "knowledgeBaseId",
    };
};

pub const IngestKnowledgeBaseDocumentsOutput = struct {
    /// A list of objects, each of which contains information about the documents
    /// that were ingested.
    document_details: ?[]const KnowledgeBaseDocumentDetail = null,

    pub const json_field_names = .{
        .document_details = "documentDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: IngestKnowledgeBaseDocumentsInput, options: CallOptions) !IngestKnowledgeBaseDocumentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: IngestKnowledgeBaseDocumentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgebases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/datasources/");
    try path_buf.appendSlice(allocator, input.data_source_id);
    try path_buf.appendSlice(allocator, "/documents");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"documents\":");
    try aws.json.writeValue(@TypeOf(input.documents), input.documents, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !IngestKnowledgeBaseDocumentsOutput {
    var result: IngestKnowledgeBaseDocumentsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(IngestKnowledgeBaseDocumentsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
