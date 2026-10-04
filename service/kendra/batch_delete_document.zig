const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceSyncJobMetricTarget = @import("data_source_sync_job_metric_target.zig").DataSourceSyncJobMetricTarget;
const BatchDeleteDocumentResponseFailedDocument = @import("batch_delete_document_response_failed_document.zig").BatchDeleteDocumentResponseFailedDocument;

pub const BatchDeleteDocumentInput = struct {
    data_source_sync_job_metric_target: ?DataSourceSyncJobMetricTarget = null,

    /// One or more identifiers for documents to delete from the index.
    document_id_list: []const []const u8,

    /// The identifier of the index that contains the documents to delete.
    index_id: []const u8,

    pub const json_field_names = .{
        .data_source_sync_job_metric_target = "DataSourceSyncJobMetricTarget",
        .document_id_list = "DocumentIdList",
        .index_id = "IndexId",
    };
};

pub const BatchDeleteDocumentOutput = struct {
    /// A list of documents that could not be removed from the index. Each entry
    /// contains an
    /// error message that indicates why the document couldn't be removed from the
    /// index.
    failed_documents: ?[]const BatchDeleteDocumentResponseFailedDocument = null,

    pub const json_field_names = .{
        .failed_documents = "FailedDocuments",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDeleteDocumentInput, options: CallOptions) !BatchDeleteDocumentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDeleteDocumentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.BatchDeleteDocument");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDeleteDocumentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchDeleteDocumentOutput, body, allocator);
}
