const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BotVersionLocaleDetails = @import("bot_version_locale_details.zig").BotVersionLocaleDetails;
const BotStatus = @import("bot_status.zig").BotStatus;

pub const CreateBotVersionInput = struct {
    /// The identifier of the bot to create the version for.
    bot_id: []const u8,

    /// Specifies the locales that Amazon Lex adds to this version. You can
    /// choose the `Draft` version or any other previously published
    /// version for each locale. When you specify a source version, the locale
    /// data is copied from the source version to the new version.
    bot_version_locale_specification: []const aws.map.MapEntry(BotVersionLocaleDetails),

    /// A description of the version. Use the description to help identify
    /// the version in lists.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version_locale_specification = "botVersionLocaleSpecification",
        .description = "description",
    };
};

pub const CreateBotVersionOutput = struct {
    /// The bot identifier specified in the request.
    bot_id: ?[]const u8 = null,

    /// When you send a request to create or update a bot, Amazon Lex sets the
    /// status response element to `Creating`. After Amazon Lex builds
    /// the bot, it sets status to `Available`. If Amazon Lex can't build
    /// the bot, it sets status to `Failed`.
    bot_status: ?BotStatus = null,

    /// The version number assigned to the version.
    bot_version: ?[]const u8 = null,

    /// The source versions used for each locale in the new version.
    bot_version_locale_specification: ?[]const aws.map.MapEntry(BotVersionLocaleDetails) = null,

    /// A timestamp of the date and time that the version was
    /// created.
    creation_date_time: ?i64 = null,

    /// The description of the version specified in the request.
    description: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_status = "botStatus",
        .bot_version = "botVersion",
        .bot_version_locale_specification = "botVersionLocaleSpecification",
        .creation_date_time = "creationDateTime",
        .description = "description",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateBotVersionInput, options: CallOptions) !CreateBotVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateBotVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botversions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"botVersionLocaleSpecification\":");
    try aws.json.writeValue(@TypeOf(input.bot_version_locale_specification), input.bot_version_locale_specification, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateBotVersionOutput {
    var result: CreateBotVersionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateBotVersionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
