const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3File = @import("s3_file.zig").S3File;

pub const CreateWhatsAppMessageTemplateMediaInput = struct {
    /// The ID of the WhatsApp Business Account associated with this media upload.
    id: []const u8,

    source_s3_file: ?S3File = null,

    pub const json_field_names = .{
        .id = "id",
        .source_s3_file = "sourceS3File",
    };
};

pub const CreateWhatsAppMessageTemplateMediaOutput = struct {
    /// The handle assigned to the uploaded media by Meta, used to reference the
    /// media in templates.
    meta_header_handle: ?[]const u8 = null,

    pub const json_field_names = .{
        .meta_header_handle = "metaHeaderHandle",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWhatsAppMessageTemplateMediaInput, options: CallOptions) !CreateWhatsAppMessageTemplateMediaOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "social-messaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWhatsAppMessageTemplateMediaInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/template/media";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"id\":");
    try aws.json.writeValue(@TypeOf(input.id), input.id, allocator, &body_buf);
    has_prev = true;
    if (input.source_s3_file) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sourceS3File\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWhatsAppMessageTemplateMediaOutput {
    const result: CreateWhatsAppMessageTemplateMediaOutput = try aws.json.parseJsonObject(
        CreateWhatsAppMessageTemplateMediaOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
