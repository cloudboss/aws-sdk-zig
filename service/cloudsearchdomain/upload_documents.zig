const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
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

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "cloudsearch");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UploadDocumentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudsearchdomain", "CloudSearch Domain", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/2013-01-01/documents/batch";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "format=sdk");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body = input.documents;

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "Content-Type", input.content_type.wireName());

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UploadDocumentsOutput {
    var result: UploadDocumentsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UploadDocumentsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "DocumentServiceException")) {
        return .{ .arena = arena, .kind = .{ .document_service_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SearchException")) {
        return .{ .arena = arena, .kind = .{ .search_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
