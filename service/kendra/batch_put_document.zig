const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomDocumentEnrichmentConfiguration = @import("custom_document_enrichment_configuration.zig").CustomDocumentEnrichmentConfiguration;
const Document = @import("document.zig").Document;
const BatchPutDocumentResponseFailedDocument = @import("batch_put_document_response_failed_document.zig").BatchPutDocumentResponseFailedDocument;

pub const BatchPutDocumentInput = struct {
    /// Configuration information for altering your document metadata and content
    /// during the
    /// document ingestion process when you use the `BatchPutDocument` API.
    ///
    /// For more information on how to create, modify and delete document metadata,
    /// or make
    /// other content alterations when you ingest documents into Amazon Kendra, see
    /// [Customizing document metadata during the ingestion
    /// process](https://docs.aws.amazon.com/kendra/latest/dg/custom-document-enrichment.html).
    custom_document_enrichment_configuration: ?CustomDocumentEnrichmentConfiguration = null,

    /// One or more documents to add to the index.
    ///
    /// Documents have the following file size limits.
    ///
    /// * 50 MB total size for any file
    ///
    /// * 5 MB extracted text for any file
    ///
    /// For more information, see
    /// [Quotas](https://docs.aws.amazon.com/kendra/latest/dg/quotas.html).
    documents: []const Document,

    /// The identifier of the index to add the documents to. You need to create the
    /// index
    /// first using the `CreateIndex` API.
    index_id: []const u8,

    /// The Amazon Resource Name (ARN) of an IAM role with permission to access
    /// your S3 bucket. For more information, see [IAM access roles for Amazon
    /// Kendra](https://docs.aws.amazon.com/kendra/latest/dg/iam-roles.html).
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .custom_document_enrichment_configuration = "CustomDocumentEnrichmentConfiguration",
        .documents = "Documents",
        .index_id = "IndexId",
        .role_arn = "RoleArn",
    };
};

pub const BatchPutDocumentOutput = struct {
    /// A list of documents that were not added to the index because the document
    /// failed a
    /// validation check. Each document contains an error message that indicates why
    /// the
    /// document couldn't be added to the index.
    ///
    /// If there was an error adding a document to an index the error is reported in
    /// your
    /// Amazon Web Services CloudWatch log. For more information, see [Monitoring
    /// Amazon Kendra with Amazon CloudWatch
    /// logs](https://docs.aws.amazon.com/kendra/latest/dg/cloudwatch-logs.html).
    failed_documents: ?[]const BatchPutDocumentResponseFailedDocument = null,

    pub const json_field_names = .{
        .failed_documents = "FailedDocuments",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchPutDocumentInput, options: CallOptions) !BatchPutDocumentOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchPutDocumentInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.BatchPutDocument");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchPutDocumentOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(BatchPutDocumentOutput, body, allocator);
}
