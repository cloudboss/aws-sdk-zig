const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StatusType = @import("status_type.zig").StatusType;
const UtteranceList = @import("utterance_list.zig").UtteranceList;

pub const GetUtterancesViewInput = struct {
    /// The name of the bot for which utterance information should be
    /// returned.
    bot_name: []const u8,

    /// An array of bot versions for which utterance information should be
    /// returned. The limit is 5 versions per request.
    bot_versions: []const []const u8,

    /// To return utterances that were recognized and handled, use
    /// `Detected`. To return utterances that were not recognized,
    /// use `Missed`.
    status_type: StatusType,

    pub const json_field_names = .{
        .bot_name = "botName",
        .bot_versions = "botVersions",
        .status_type = "statusType",
    };
};

pub const GetUtterancesViewOutput = struct {
    /// The name of the bot for which utterance information was
    /// returned.
    bot_name: ?[]const u8 = null,

    /// An array of UtteranceList objects, each
    /// containing a list of UtteranceData objects describing
    /// the utterances that were processed by your bot. The response contains a
    /// maximum of 100 `UtteranceData` objects for each version. Amazon Lex
    /// returns the most frequent utterances received by the bot in the last 15
    /// days.
    utterances: ?[]const UtteranceList = null,

    pub const json_field_names = .{
        .bot_name = "botName",
        .utterances = "utterances",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetUtterancesViewInput, options: CallOptions) !GetUtterancesViewOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetUtterancesViewInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models.lex", "Lex Model Building Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_name);
    try path_buf.appendSlice(allocator, "/utterances");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "view=aggregation");
    query_has_prev = true;
    for (input.bot_versions) |item| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "bot_versions=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, item);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "status_type=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.status_type.wireName());
    query_has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetUtterancesViewOutput {
    const result: GetUtterancesViewOutput = try aws.json.parseJsonObject(
        GetUtterancesViewOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
