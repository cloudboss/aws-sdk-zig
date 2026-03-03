const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ActionExecution = @import("action_execution.zig").ActionExecution;
const AttachmentInput = @import("attachment_input.zig").AttachmentInput;
const AttributeFilter = @import("attribute_filter.zig").AttributeFilter;
const AuthChallengeResponse = @import("auth_challenge_response.zig").AuthChallengeResponse;
const ChatMode = @import("chat_mode.zig").ChatMode;
const ChatModeConfiguration = @import("chat_mode_configuration.zig").ChatModeConfiguration;
const ActionReview = @import("action_review.zig").ActionReview;
const AuthChallengeRequest = @import("auth_challenge_request.zig").AuthChallengeRequest;
const AttachmentOutput = @import("attachment_output.zig").AttachmentOutput;
const SourceAttribution = @import("source_attribution.zig").SourceAttribution;

pub const ChatSyncInput = struct {
    /// A request from an end user to perform an Amazon Q Business plugin action.
    action_execution: ?ActionExecution = null,

    /// The identifier of the Amazon Q Business application linked to the Amazon Q
    /// Business conversation.
    application_id: []const u8,

    /// A list of files uploaded directly during chat. You can upload a maximum of 5
    /// files of upto 10 MB each.
    attachments: ?[]const AttachmentInput = null,

    /// Enables filtering of Amazon Q Business web experience responses based on
    /// document attributes or metadata fields.
    attribute_filter: ?AttributeFilter = null,

    /// An authentication verification event response by a third party
    /// authentication server to Amazon Q Business.
    auth_challenge_response: ?AuthChallengeResponse = null,

    /// The `chatMode` parameter determines the chat modes available to Amazon Q
    /// Business users:
    ///
    /// * `RETRIEVAL_MODE` - If you choose this mode, Amazon Q generates responses
    ///   solely from the data sources connected and indexed by the application. If
    ///   an answer is not found in the data sources or there are no data sources
    ///   available, Amazon Q will respond with a "*No Answer Found*" message,
    ///   unless LLM knowledge has been enabled. In that case, Amazon Q will
    ///   generate a response from the LLM knowledge
    /// * `CREATOR_MODE` - By selecting this mode, you can choose to generate
    ///   responses only from the LLM knowledge. You can also attach files and have
    ///   Amazon Q generate a response based on the data in those files. If the
    ///   attached files do not contain an answer for the query, Amazon Q will
    ///   automatically fall back to generating a response from the LLM knowledge.
    /// * `PLUGIN_MODE` - By selecting this mode, users can choose to use plugins in
    ///   chat to get their responses.
    ///
    /// If none of the modes are selected, Amazon Q will only respond using the
    /// information from the attached files.
    ///
    /// For more information, see [Admin controls and
    /// guardrails](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/guardrails.html), [Plugins](https://docs.aws.amazon.com/amazonq/latest/qbusiness-ug/plugins.html), and [Response sources](https://docs.aws.amazon.com/amazonq/latest/business-use-dg/using-web-experience.html#chat-source-scope).
    chat_mode: ?ChatMode = null,

    /// The chat mode configuration for an Amazon Q Business application.
    chat_mode_configuration: ?ChatModeConfiguration = null,

    /// A token that you provide to identify a chat request.
    client_token: ?[]const u8 = null,

    /// The identifier of the Amazon Q Business conversation.
    conversation_id: ?[]const u8 = null,

    /// The identifier of the previous system message in a conversation.
    parent_message_id: ?[]const u8 = null,

    /// The group names that a user associated with the chat input belongs to.
    user_groups: ?[]const []const u8 = null,

    /// The identifier of the user attached to the chat input.
    user_id: ?[]const u8 = null,

    /// A end user message in a conversation.
    user_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_execution = "actionExecution",
        .application_id = "applicationId",
        .attachments = "attachments",
        .attribute_filter = "attributeFilter",
        .auth_challenge_response = "authChallengeResponse",
        .chat_mode = "chatMode",
        .chat_mode_configuration = "chatModeConfiguration",
        .client_token = "clientToken",
        .conversation_id = "conversationId",
        .parent_message_id = "parentMessageId",
        .user_groups = "userGroups",
        .user_id = "userId",
        .user_message = "userMessage",
    };
};

pub const ChatSyncOutput = struct {
    /// A request from Amazon Q Business to the end user for information Amazon Q
    /// Business needs to successfully complete a requested plugin action.
    action_review: ?ActionReview = null,

    /// An authentication verification event activated by an end user request to use
    /// a custom plugin.
    auth_challenge_request: ?AuthChallengeRequest = null,

    /// The identifier of the Amazon Q Business conversation.
    conversation_id: ?[]const u8 = null,

    /// A list of files which failed to upload during chat.
    failed_attachments: ?[]const AttachmentOutput = null,

    /// The source documents used to generate the conversation response.
    source_attributions: ?[]const SourceAttribution = null,

    /// An AI-generated message in a conversation.
    system_message: ?[]const u8 = null,

    /// The identifier of an Amazon Q Business AI generated message within the
    /// conversation.
    system_message_id: ?[]const u8 = null,

    /// The identifier of an Amazon Q Business end user text input message within
    /// the conversation.
    user_message_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_review = "actionReview",
        .auth_challenge_request = "authChallengeRequest",
        .conversation_id = "conversationId",
        .failed_attachments = "failedAttachments",
        .source_attributions = "sourceAttributions",
        .system_message = "systemMessage",
        .system_message_id = "systemMessageId",
        .user_message_id = "userMessageId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ChatSyncInput, options: Options) !ChatSyncOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "qbusiness");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ChatSyncInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("qbusiness", "QBusiness", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_id);
    try path_buf.appendSlice(allocator, "/conversations");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "sync");
    query_has_prev = true;
    if (input.user_groups) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "userGroups=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.user_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "userId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.action_execution) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"actionExecution\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.attachments) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"attachments\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.attribute_filter) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"attributeFilter\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.auth_challenge_response) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authChallengeResponse\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.chat_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"chatMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.chat_mode_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"chatModeConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.conversation_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"conversationId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parent_message_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parentMessageId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.user_message) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"userMessage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ChatSyncOutput {
    var result: ChatSyncOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ChatSyncOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ExternalResourceException")) {
        return .{ .arena = arena, .kind = .{ .external_resource_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LicenseNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .license_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MediaTooLargeException")) {
        return .{ .arena = arena, .kind = .{ .media_too_large_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
