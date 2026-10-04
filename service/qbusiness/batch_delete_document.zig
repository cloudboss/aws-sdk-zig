const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeleteDocument = @import("delete_document.zig").DeleteDocument;
const FailedDocument = @import("failed_document.zig").FailedDocument;

pub const BatchDeleteDocumentInput = struct {
    /// The identifier of the Amazon Q Business application.
    application_id: []const u8,

    /// The identifier of the data source sync during which the documents were
    /// deleted.
    data_source_sync_id: ?[]const u8 = null,

    /// Documents deleted from the Amazon Q Business index.
    documents: []const DeleteDocument,

    /// The identifier of the Amazon Q Business index that contains the documents to
    /// delete.
    index_id: []const u8,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .data_source_sync_id = "dataSourceSyncId",
        .documents = "documents",
        .index_id = "indexId",
    };
};

pub const BatchDeleteDocumentOutput = struct {
    /// A list of documents that couldn't be removed from the Amazon Q Business
    /// index. Each entry contains an error message that indicates why the document
    /// couldn't be removed from the index.
    failed_documents: ?[]const FailedDocument = null,

    pub const json_field_names = .{
        .failed_documents = "failedDocuments",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDeleteDocumentInput, options: CallOptions) !BatchDeleteDocumentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qbusiness", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDeleteDocumentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/indices/");
    try path_buf.appendSlice(allocator, input.index_id);
    try path_buf.appendSlice(allocator, "/documents/delete");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.data_source_sync_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dataSourceSyncId\":");
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
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDeleteDocumentOutput {
    const result: BatchDeleteDocumentOutput = try aws.json.parseJsonObject(
        BatchDeleteDocumentOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
