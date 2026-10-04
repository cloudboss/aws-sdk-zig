const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DocumentInfo = @import("document_info.zig").DocumentInfo;
const Status = @import("status.zig").Status;
const BatchGetDocumentStatusResponseError = @import("batch_get_document_status_response_error.zig").BatchGetDocumentStatusResponseError;

pub const BatchGetDocumentStatusInput = struct {
    /// A list of `DocumentInfo` objects that identify the documents for which to
    /// get the status. You identify the documents by their document ID and optional
    /// attributes.
    document_info_list: []const DocumentInfo,

    /// The identifier of the index to add documents to. The index ID is returned by
    /// the
    /// [CreateIndex
    /// ](https://docs.aws.amazon.com/kendra/latest/dg/API_CreateIndex.html) API.
    index_id: []const u8,

    pub const json_field_names = .{
        .document_info_list = "DocumentInfoList",
        .index_id = "IndexId",
    };
};

pub const BatchGetDocumentStatusOutput = struct {
    /// The status of documents. The status indicates if the document is waiting to
    /// be
    /// indexed, is in the process of indexing, has completed indexing, or failed
    /// indexing. If a
    /// document failed indexing, the status provides the reason why.
    document_status_list: ?[]const Status = null,

    /// A list of documents that Amazon Kendra couldn't get the status for. The list
    /// includes the ID of the document and the reason that the status couldn't be
    /// found.
    errors: ?[]const BatchGetDocumentStatusResponseError = null,

    pub const json_field_names = .{
        .document_status_list = "DocumentStatusList",
        .errors = "Errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetDocumentStatusInput, options: CallOptions) !BatchGetDocumentStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetDocumentStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.BatchGetDocumentStatus");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetDocumentStatusOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchGetDocumentStatusOutput, body, allocator);
}
