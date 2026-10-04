const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QuickResponseDataProvider = @import("quick_response_data_provider.zig").QuickResponseDataProvider;
const GroupingConfiguration = @import("grouping_configuration.zig").GroupingConfiguration;
const QuickResponseData = @import("quick_response_data.zig").QuickResponseData;

pub const CreateQuickResponseInput = struct {
    /// The Amazon Connect channels this quick response applies to.
    channels: ?[]const []const u8 = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If not provided, the Amazon Web Services SDK
    /// populates this field. For more information about idempotency, see [Making
    /// retries safe with idempotent
    /// APIs](http://aws.amazon.com/builders-library/making-retries-safe-with-idempotent-APIs/).
    client_token: ?[]const u8 = null,

    /// The content of the quick response.
    content: QuickResponseDataProvider,

    /// The media type of the quick response content.
    ///
    /// * Use `application/x.quickresponse;format=plain` for a quick response
    ///   written in plain text.
    /// * Use `application/x.quickresponse;format=markdown` for a quick response
    ///   written in richtext.
    content_type: ?[]const u8 = null,

    /// The description of the quick response.
    description: ?[]const u8 = null,

    /// The configuration information of the user groups that the quick response is
    /// accessible to.
    grouping_configuration: ?GroupingConfiguration = null,

    /// Whether the quick response is active.
    is_active: ?bool = null,

    /// The identifier of the knowledge base. Can be either the ID or the ARN. URLs
    /// cannot contain the ARN.
    knowledge_base_id: []const u8,

    /// The language code value for the language in which the quick response is
    /// written. The supported language codes include `de_DE`, `en_US`, `es_ES`,
    /// `fr_FR`, `id_ID`, `it_IT`, `ja_JP`, `ko_KR`, `pt_BR`, `zh_CN`, `zh_TW`
    language: ?[]const u8 = null,

    /// The name of the quick response.
    name: []const u8,

    /// The shortcut key of the quick response. The value should be unique across
    /// the knowledge base.
    shortcut_key: ?[]const u8 = null,

    /// The tags used to organize, track, or control access for this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .channels = "channels",
        .client_token = "clientToken",
        .content = "content",
        .content_type = "contentType",
        .description = "description",
        .grouping_configuration = "groupingConfiguration",
        .is_active = "isActive",
        .knowledge_base_id = "knowledgeBaseId",
        .language = "language",
        .name = "name",
        .shortcut_key = "shortcutKey",
        .tags = "tags",
    };
};

pub const CreateQuickResponseOutput = struct {
    /// The quick response.
    quick_response: ?QuickResponseData = null,

    pub const json_field_names = .{
        .quick_response = "quickResponse",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateQuickResponseInput, options: CallOptions) !CreateQuickResponseOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateQuickResponseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wisdom", "QConnect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/knowledgeBases/");
    try path_buf.appendSlice(allocator, input.knowledge_base_id);
    try path_buf.appendSlice(allocator, "/quickResponses");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.channels) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"channels\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"content\":");
    try aws.json.writeValue(@TypeOf(input.content), input.content, allocator, &body_buf);
    has_prev = true;
    if (input.content_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"contentType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.grouping_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"groupingConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.is_active) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"isActive\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.language) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"language\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.shortcut_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"shortcutKey\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateQuickResponseOutput {
    var result: CreateQuickResponseOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateQuickResponseOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
