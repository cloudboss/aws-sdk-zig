const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetaFlowPreviewInfo = @import("meta_flow_preview_info.zig").MetaFlowPreviewInfo;

pub const GetWhatsAppFlowPreviewInput = struct {
    /// The unique identifier of the Flow to preview.
    flow_id: []const u8,

    /// The ID of the WhatsApp Business Account associated with this Flow.
    id: []const u8,

    /// Set to `true` to force generation of a new preview URL. Use this if the
    /// previous URL has been compromised or you want a fresh expiration period.
    invalidate: ?bool = null,

    pub const json_field_names = .{
        .flow_id = "flowId",
        .id = "id",
        .invalidate = "invalidate",
    };
};

pub const GetWhatsAppFlowPreviewOutput = struct {
    /// The unique identifier of the Flow.
    flow_id: []const u8,

    /// The preview URL and its expiration timestamp.
    preview: ?MetaFlowPreviewInfo = null,

    pub const json_field_names = .{
        .flow_id = "flowId",
        .preview = "preview",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetWhatsAppFlowPreviewInput, options: CallOptions) !GetWhatsAppFlowPreviewOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetWhatsAppFlowPreviewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/flow/preview";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "flowId=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.flow_id);
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "id=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.id);
    query_has_prev = true;
    if (input.invalidate) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "invalidate=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetWhatsAppFlowPreviewOutput {
    const result: GetWhatsAppFlowPreviewOutput = try aws.json.parseJsonObject(
        GetWhatsAppFlowPreviewOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
