const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ActiveContext = @import("active_context.zig").ActiveContext;
const DialogAction = @import("dialog_action.zig").DialogAction;
const IntentSummary = @import("intent_summary.zig").IntentSummary;

pub const GetSessionInput = struct {
    /// The alias in use for the bot that contains the session data.
    bot_alias: []const u8,

    /// The name of the bot that contains the session data.
    bot_name: []const u8,

    /// A string used to filter the intents returned in the
    /// `recentIntentSummaryView` structure.
    ///
    /// When you specify a filter, only intents with their
    /// `checkpointLabel` field set to that string are
    /// returned.
    checkpoint_label_filter: ?[]const u8 = null,

    /// The ID of the client application user. Amazon Lex uses this to identify a
    /// user's conversation with your bot.
    user_id: []const u8,

    pub const json_field_names = .{
        .bot_alias = "botAlias",
        .bot_name = "botName",
        .checkpoint_label_filter = "checkpointLabelFilter",
        .user_id = "userId",
    };
};

pub const GetSessionOutput = struct {
    /// A list of active contexts for the session. A context can be set when
    /// an intent is fulfilled or by calling the `PostContent`,
    /// `PostText`, or `PutSession` operation.
    ///
    /// You can use a context to control the intents that can follow up an
    /// intent, or to modify the operation of your application.
    active_contexts: ?[]const ActiveContext = null,

    /// Describes the current state of the bot.
    dialog_action: ?DialogAction = null,

    /// An array of information about the intents used in the session. The
    /// array can contain a maximum of three summaries. If more than three intents
    /// are used in the session, the `recentIntentSummaryView`
    /// operation contains information about the last three intents used.
    ///
    /// If you set the `checkpointLabelFilter` parameter in the
    /// request, the array contains only the intents with the specified
    /// label.
    recent_intent_summary_view: ?[]const IntentSummary = null,

    /// Map of key/value pairs representing the session-specific context
    /// information. It contains application information passed between Amazon Lex
    /// and
    /// a client application.
    session_attributes: ?[]const aws.map.StringMapEntry = null,

    /// A unique identifier for the session.
    session_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_contexts = "activeContexts",
        .dialog_action = "dialogAction",
        .recent_intent_summary_view = "recentIntentSummaryView",
        .session_attributes = "sessionAttributes",
        .session_id = "sessionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSessionInput, options: CallOptions) !GetSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lex", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("runtime.lex", "Lex Runtime Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bot/");
    try path_buf.appendSlice(allocator, input.bot_name);
    try path_buf.appendSlice(allocator, "/alias/");
    try path_buf.appendSlice(allocator, input.bot_alias);
    try path_buf.appendSlice(allocator, "/user/");
    try path_buf.appendSlice(allocator, input.user_id);
    try path_buf.appendSlice(allocator, "/session");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.checkpoint_label_filter) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "checkpointLabelFilter=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSessionOutput {
    const result: GetSessionOutput = try aws.json.parseJsonObject(
        GetSessionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
