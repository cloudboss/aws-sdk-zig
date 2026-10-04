const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MessageTemplateContentProvider = @import("message_template_content_provider.zig").MessageTemplateContentProvider;
const MessageTemplateAttributes = @import("message_template_attributes.zig").MessageTemplateAttributes;
const MessageTemplateSourceConfiguration = @import("message_template_source_configuration.zig").MessageTemplateSourceConfiguration;
const MessageTemplateData = @import("message_template_data.zig").MessageTemplateData;

pub const UpdateMessageTemplateInput = struct {
    /// The content of the message template.
    content: ?MessageTemplateContentProvider = null,

    /// An object that specifies the default values to use for variables in the
    /// message template. This object contains different categories of key-value
    /// pairs. Each key defines a variable or placeholder in the message template.
    /// The corresponding value defines the default value for that variable.
    default_attributes: ?MessageTemplateAttributes = null,

    /// The identifier of the knowledge base. Can be either the ID or the ARN. URLs
    /// cannot contain the ARN.
    knowledge_base_id: []const u8,

    /// The language code value for the language in which the quick response is
    /// written. The supported language codes include `de_DE`, `en_US`, `es_ES`,
    /// `fr_FR`, `id_ID`, `it_IT`, `ja_JP`, `ko_KR`, `pt_BR`, `zh_CN`, `zh_TW`
    language: ?[]const u8 = null,

    /// The identifier of the message template. Can be either the ID or the ARN. It
    /// cannot contain any qualifier.
    message_template_id: []const u8,

    /// The source configuration of the message template. Only set this argument for
    /// WHATSAPP channel subtype.
    source_configuration: ?MessageTemplateSourceConfiguration = null,

    pub const json_field_names = .{
        .content = "content",
        .default_attributes = "defaultAttributes",
        .knowledge_base_id = "knowledgeBaseId",
        .language = "language",
        .message_template_id = "messageTemplateId",
        .source_configuration = "sourceConfiguration",
    };
};

pub const UpdateMessageTemplateOutput = struct {
    /// The message template.
    message_template: ?MessageTemplateData = null,

    pub const json_field_names = .{
        .message_template = "messageTemplate",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMessageTemplateInput, options: CallOptions) !UpdateMessageTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMessageTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgeBases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/messageTemplates/");
    try path_buf.appendSlice(allocator, input.message_template_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.content) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"content\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.default_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"defaultAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.language) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"language\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.source_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sourceConfiguration\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMessageTemplateOutput {
    const result: UpdateMessageTemplateOutput = try aws.json.parseJsonObject(
        UpdateMessageTemplateOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
