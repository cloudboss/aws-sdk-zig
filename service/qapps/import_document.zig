const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DocumentScope = @import("document_scope.zig").DocumentScope;

pub const ImportDocumentInput = struct {
    /// The unique identifier of the Q App the file is associated with.
    app_id: []const u8,

    /// The unique identifier of the card the file is associated with.
    card_id: []const u8,

    /// The base64-encoded contents of the file to upload.
    file_contents_base_64: []const u8,

    /// The name of the file being uploaded.
    file_name: []const u8,

    /// The unique identifier of the Amazon Q Business application environment
    /// instance.
    instance_id: []const u8,

    /// Whether the file is associated with a Q App definition or a specific Q App
    /// session.
    scope: DocumentScope,

    /// The unique identifier of the Q App session the file is associated with, if
    /// applicable.
    session_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_id = "appId",
        .card_id = "cardId",
        .file_contents_base_64 = "fileContentsBase64",
        .file_name = "fileName",
        .instance_id = "instanceId",
        .scope = "scope",
        .session_id = "sessionId",
    };
};

pub const ImportDocumentOutput = struct {
    /// The unique identifier assigned to the uploaded file.
    file_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_id = "fileId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportDocumentInput, options: CallOptions) !ImportDocumentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "qapps", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportDocumentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.qapps", "QApps", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/apps.importDocument";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"appId\":");
    try aws.json.writeValue(@TypeOf(input.app_id), input.app_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"cardId\":");
    try aws.json.writeValue(@TypeOf(input.card_id), input.card_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"fileContentsBase64\":");
    try aws.json.writeValue(@TypeOf(input.file_contents_base_64), input.file_contents_base_64, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"fileName\":");
    try aws.json.writeValue(@TypeOf(input.file_name), input.file_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"scope\":");
    try aws.json.writeValue(@TypeOf(input.scope), input.scope, allocator, &body_buf);
    has_prev = true;
    if (input.session_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionId\":");
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
    try request.headers.put(allocator, "instance-id", input.instance_id);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportDocumentOutput {
    var result: ImportDocumentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ImportDocumentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
