const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContentType = @import("content_type.zig").ContentType;
const DocumentServiceWarning = @import("document_service_warning.zig").DocumentServiceWarning;

pub const UploadDocumentsInput = struct {
    /// The format of the batch you are uploading. Amazon CloudSearch supports two
    /// document batch formats:
    ///
    /// * application/json
    ///
    /// * application/xml
    content_type: ContentType,

    /// A batch of documents formatted in JSON or HTML.
    documents: []const u8,

    pub const json_field_names = .{
        .content_type = "contentType",
        .documents = "documents",
    };
};

pub const UploadDocumentsOutput = struct {
    /// The number of documents that were added to the search domain.
    adds: ?i64 = null,

    /// The number of documents that were deleted from the search domain.
    deletes: ?i64 = null,

    /// The status of an `UploadDocumentsRequest`.
    status: ?[]const u8 = null,

    /// Any warnings returned by the document service about the documents being
    /// uploaded.
    warnings: ?[]const DocumentServiceWarning = null,

    pub const json_field_names = .{
        .adds = "adds",
        .deletes = "deletes",
        .status = "status",
        .warnings = "warnings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UploadDocumentsInput, options: CallOptions) !UploadDocumentsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudsearch", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UploadDocumentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudsearchdomain", "CloudSearch Domain", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2013-01-01/documents/batch";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "format=sdk");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body = input.documents;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "Content-Type", input.content_type.wireName());

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UploadDocumentsOutput {
    const result: UploadDocumentsOutput = try aws.json.parseJsonObject(
        UploadDocumentsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
