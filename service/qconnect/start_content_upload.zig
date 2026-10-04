const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const StartContentUploadInput = struct {
    /// The type of content to upload.
    content_type: []const u8,

    /// The identifier of the knowledge base. Can be either the ID or the ARN. URLs
    /// cannot contain the ARN.
    knowledge_base_id: []const u8,

    /// The expected expiration time of the generated presigned URL, specified in
    /// minutes.
    presigned_url_time_to_live: ?i32 = null,

    pub const json_field_names = .{
        .content_type = "contentType",
        .knowledge_base_id = "knowledgeBaseId",
        .presigned_url_time_to_live = "presignedUrlTimeToLive",
    };
};

pub const StartContentUploadOutput = struct {
    /// The headers to include in the upload.
    headers_to_include: ?[]const aws.map.StringMapEntry = null,

    /// The identifier of the upload.
    upload_id: []const u8,

    /// The URL of the upload.
    url: []const u8,

    /// The expiration time of the URL as an epoch timestamp.
    url_expiry: i64,

    pub const json_field_names = .{
        .headers_to_include = "headersToInclude",
        .upload_id = "uploadId",
        .url = "url",
        .url_expiry = "urlExpiry",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartContentUploadInput, options: CallOptions) !StartContentUploadOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wisdom", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartContentUploadInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgeBases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/upload");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"contentType\":");
    try aws.json.writeValue(@TypeOf(input.content_type), input.content_type, allocator, &body_buf);
    has_prev = true;
    if (input.presigned_url_time_to_live) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"presignedUrlTimeToLive\":");
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartContentUploadOutput {
    var result: StartContentUploadOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartContentUploadOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
