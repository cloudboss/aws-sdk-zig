const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MessageTemplateAttributes = @import("message_template_attributes.zig").MessageTemplateAttributes;
const MessageTemplateAttachment = @import("message_template_attachment.zig").MessageTemplateAttachment;
const MessageTemplateContentProvider = @import("message_template_content_provider.zig").MessageTemplateContentProvider;
const MessageTemplateSourceConfigurationSummary = @import("message_template_source_configuration_summary.zig").MessageTemplateSourceConfigurationSummary;

pub const RenderMessageTemplateInput = struct {
    /// An object that specifies the values to use for variables in the message
    /// template. This object contains different categories of key-value pairs. Each
    /// key defines a variable or placeholder in the message template. The
    /// corresponding value defines the value for that variable.
    attributes: MessageTemplateAttributes,

    /// The identifier of the knowledge base. Can be either the ID or the ARN. URLs
    /// cannot contain the ARN.
    knowledge_base_id: []const u8,

    /// The identifier of the message template. Can be either the ID or the ARN.
    message_template_id: []const u8,

    pub const json_field_names = .{
        .attributes = "attributes",
        .knowledge_base_id = "knowledgeBaseId",
        .message_template_id = "messageTemplateId",
    };
};

pub const RenderMessageTemplateOutput = struct {
    /// The message template attachments.
    attachments: ?[]const MessageTemplateAttachment = null,

    /// The attribute keys that are not resolved.
    attributes_not_interpolated: ?[]const []const u8 = null,

    /// The content of the message template.
    content: ?MessageTemplateContentProvider = null,

    /// The source configuration of the message template.
    source_configuration_summary: ?MessageTemplateSourceConfigurationSummary = null,

    pub const json_field_names = .{
        .attachments = "attachments",
        .attributes_not_interpolated = "attributesNotInterpolated",
        .content = "content",
        .source_configuration_summary = "sourceConfigurationSummary",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RenderMessageTemplateInput, options: CallOptions) !RenderMessageTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RenderMessageTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgeBases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/messageTemplates/");
    try path_buf.appendSlice(allocator, input.message_template_id);
    try path_buf.appendSlice(allocator, "/render");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"attributes\":");
    try aws.json.writeValue(@TypeOf(input.attributes), input.attributes, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RenderMessageTemplateOutput {
    const result: RenderMessageTemplateOutput = try aws.json.parseJsonObject(
        RenderMessageTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
