const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateWhatsAppMessageTemplateInput = struct {
    /// The ID of the WhatsApp Business Account to associate with this template.
    id: []const u8,

    /// The complete template definition as a JSON blob.
    template_definition: []const u8,

    pub const json_field_names = .{
        .id = "id",
        .template_definition = "templateDefinition",
    };
};

pub const CreateWhatsAppMessageTemplateOutput = struct {
    /// The category of the template, such as UTILITY or MARKETING.
    category: ?[]const u8 = null,

    /// The numeric ID assigned to the template by Meta.
    meta_template_id: ?[]const u8 = null,

    /// The status of the created template, such as PENDING or APPROVED..
    template_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .category = "category",
        .meta_template_id = "metaTemplateId",
        .template_status = "templateStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWhatsAppMessageTemplateInput, options: CallOptions) !CreateWhatsAppMessageTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWhatsAppMessageTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("social-messaging", "SocialMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/v1/whatsapp/template/put";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"id\":");
    try aws.json.writeValue(@TypeOf(input.id), input.id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"templateDefinition\":");
    try aws.json.writeValue(@TypeOf(input.template_definition), input.template_definition, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWhatsAppMessageTemplateOutput {
    var result: CreateWhatsAppMessageTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateWhatsAppMessageTemplateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
