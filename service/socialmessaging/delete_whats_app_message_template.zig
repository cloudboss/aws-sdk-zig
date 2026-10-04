const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteWhatsAppMessageTemplateInput = struct {
    /// If true, deletes all language versions of the template.
    delete_all_languages: ?bool = null,

    /// The ID of the WhatsApp Business Account associated with this template.
    id: []const u8,

    /// The numeric ID of the template assigned by Meta.
    meta_template_id: ?[]const u8 = null,

    /// The name of the template to delete.
    template_name: []const u8,

    pub const json_field_names = .{
        .delete_all_languages = "deleteAllLanguages",
        .id = "id",
        .meta_template_id = "metaTemplateId",
        .template_name = "templateName",
    };
};

pub const DeleteWhatsAppMessageTemplateOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteWhatsAppMessageTemplateInput, options: CallOptions) !DeleteWhatsAppMessageTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteWhatsAppMessageTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/template";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.delete_all_languages) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "deleteAllTemplates=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "id=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.id);
    query_has_prev = true;
    if (input.meta_template_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "metaTemplateId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "templateName=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.template_name);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteWhatsAppMessageTemplateOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DeleteWhatsAppMessageTemplateOutput = .{};

    return result;
}
