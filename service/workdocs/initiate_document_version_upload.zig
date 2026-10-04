const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DocumentMetadata = @import("document_metadata.zig").DocumentMetadata;
const UploadMetadata = @import("upload_metadata.zig").UploadMetadata;

pub const InitiateDocumentVersionUploadInput = struct {
    /// Amazon WorkDocs authentication token. Not required when using Amazon Web
    /// Services administrator credentials to access the API.
    authentication_token: ?[]const u8 = null,

    /// The timestamp when the content of the document was originally created.
    content_created_timestamp: ?i64 = null,

    /// The timestamp when the content of the document was modified.
    content_modified_timestamp: ?i64 = null,

    /// The content type of the document.
    content_type: ?[]const u8 = null,

    /// The size of the document, in bytes.
    document_size_in_bytes: ?i64 = null,

    /// The ID of the document.
    id: ?[]const u8 = null,

    /// The name of the document.
    name: ?[]const u8 = null,

    /// The ID of the parent folder.
    parent_folder_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .authentication_token = "AuthenticationToken",
        .content_created_timestamp = "ContentCreatedTimestamp",
        .content_modified_timestamp = "ContentModifiedTimestamp",
        .content_type = "ContentType",
        .document_size_in_bytes = "DocumentSizeInBytes",
        .id = "Id",
        .name = "Name",
        .parent_folder_id = "ParentFolderId",
    };
};

pub const InitiateDocumentVersionUploadOutput = struct {
    /// The document metadata.
    metadata: ?DocumentMetadata = null,

    /// The upload metadata.
    upload_metadata: ?UploadMetadata = null,

    pub const json_field_names = .{
        .metadata = "Metadata",
        .upload_metadata = "UploadMetadata",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: InitiateDocumentVersionUploadInput, options: CallOptions) !InitiateDocumentVersionUploadOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workdocs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: InitiateDocumentVersionUploadInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workdocs", "WorkDocs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/api/v1/documents";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.content_created_timestamp) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ContentCreatedTimestamp\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.content_modified_timestamp) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ContentModifiedTimestamp\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.content_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ContentType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.document_size_in_bytes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DocumentSizeInBytes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Id\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parent_folder_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ParentFolderId\":");
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
    if (input.authentication_token) |v| {
        try request.headers.put(allocator, "Authentication", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !InitiateDocumentVersionUploadOutput {
    var result: InitiateDocumentVersionUploadOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(InitiateDocumentVersionUploadOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
