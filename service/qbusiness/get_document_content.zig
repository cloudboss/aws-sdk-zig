const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OutputFormat = @import("output_format.zig").OutputFormat;

pub const GetDocumentContentInput = struct {
    /// The unique identifier of the Amazon Q Business application containing the
    /// document. This ensures the request is scoped to the correct application
    /// environment and its associated security policies.
    application_id: []const u8,

    /// The identifier of the data source from which the document was ingested. This
    /// field is not present if the document is ingested by directly calling the
    /// BatchPutDocument API. If the document is from a file-upload data source, the
    /// datasource will be "uploaded-docs-file-stat-datasourceid".
    data_source_id: ?[]const u8 = null,

    /// The unique identifier of the document that is indexed via BatchPutDocument
    /// API or file-upload or connector sync. It is also found in chat or chatSync
    /// response.
    document_id: []const u8,

    /// The identifier of the index where documents are indexed.
    index_id: []const u8,

    /// Document outputFormat. Defaults to RAW if not selected.
    output_format: ?OutputFormat = null,

    pub const json_field_names = .{
        .application_id = "applicationId",
        .data_source_id = "dataSourceId",
        .document_id = "documentId",
        .index_id = "indexId",
        .output_format = "outputFormat",
    };
};

pub const GetDocumentContentOutput = struct {
    /// The MIME type of the document content. When outputFormat is RAW, this
    /// corresponds to the original document's MIME type (e.g., application/pdf,
    /// text/plain,
    /// application/vnd.openxmlformats-officedocument.wordprocessingml.document).
    /// When outputFormat is EXTRACTED, the MIME type is always application/json.
    mime_type: []const u8,

    /// A pre-signed URL that provides temporary access to download the document
    /// content directly from Amazon Q Business. The URL expires after 5 minutes for
    /// security purposes. This URL is generated only after successful ACL
    /// validation.
    presigned_url: []const u8,

    pub const json_field_names = .{
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDocumentContentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/index/");
    try path_buf.appendSlice(allocator, input.index_id);
    try path_buf.appendSlice(allocator, "/documents/");
    try path_buf.appendSlice(allocator, input.document_id);
    try path_buf.appendSlice(allocator, "/content");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.data_source_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "dataSourceId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.output_format) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "outputFormat=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDocumentContentOutput {
    var result: GetDocumentContentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDocumentContentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
