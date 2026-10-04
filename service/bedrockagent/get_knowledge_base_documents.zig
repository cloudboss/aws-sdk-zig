const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DocumentIdentifier = @import("document_identifier.zig").DocumentIdentifier;
const KnowledgeBaseDocumentDetail = @import("knowledge_base_document_detail.zig").KnowledgeBaseDocumentDetail;

pub const GetKnowledgeBaseDocumentsInput = struct {
    /// The unique identifier of the data source that contains the documents.
    data_source_id: []const u8,

    /// A list of objects, each of which contains information to identify a document
    /// for which to retrieve information.
    document_identifiers: []const DocumentIdentifier,

    /// The unique identifier of the knowledge base that is connected to the data
    /// source.
    knowledge_base_id: []const u8,

    pub const json_field_names = .{
        .data_source_id = "dataSourceId",
        .document_identifiers = "documentIdentifiers",
        .knowledge_base_id = "knowledgeBaseId",
    };
};

pub const GetKnowledgeBaseDocumentsOutput = struct {
    /// A list of objects, each of which contains information about the documents
    /// that were retrieved.
    document_details: ?[]const KnowledgeBaseDocumentDetail = null,

    pub const json_field_names = .{
        .document_details = "documentDetails",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetKnowledgeBaseDocumentsInput, options: CallOptions) !GetKnowledgeBaseDocumentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetKnowledgeBaseDocumentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agent", "Bedrock Agent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgebases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/datasources/");
    try path_buf.appendSlice(allocator, input.data_source_id);
    try path_buf.appendSlice(allocator, "/documents/getDocuments");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"documentIdentifiers\":");
    try aws.json.writeValue(@TypeOf(input.document_identifiers), input.document_identifiers, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetKnowledgeBaseDocumentsOutput {
    var result: GetKnowledgeBaseDocumentsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetKnowledgeBaseDocumentsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
