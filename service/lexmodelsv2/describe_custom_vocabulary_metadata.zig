const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomVocabularyStatus = @import("custom_vocabulary_status.zig").CustomVocabularyStatus;

pub const DescribeCustomVocabularyMetadataInput = struct {
    /// The unique identifier of the bot that contains the custom vocabulary.
    bot_id: []const u8,

    /// The bot version of the bot to return metadata for.
    bot_version: []const u8,

    /// The locale to return the custom vocabulary information for.
    /// The locale must be `en_GB`.
    locale_id: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .locale_id = "localeId",
    };
};

pub const DescribeCustomVocabularyMetadataOutput = struct {
    /// The identifier of the bot that contains the custom vocabulary.
    bot_id: ?[]const u8 = null,

    /// The version of the bot that contains the custom vocabulary to describe.
    bot_version: ?[]const u8 = null,

    /// The date and time that the custom vocabulary was created.
    creation_date_time: ?i64 = null,

    /// The status of the custom vocabulary. If the status is
    /// `Ready` the custom vocabulary is ready to use.
    custom_vocabulary_status: ?CustomVocabularyStatus = null,

    /// The date and time that the custom vocabulary was last updated.
    last_updated_date_time: ?i64 = null,

    /// The locale that contains the custom vocabulary to describe.
    locale_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .creation_date_time = "creationDateTime",
        .custom_vocabulary_status = "customVocabularyStatus",
        .last_updated_date_time = "lastUpdatedDateTime",
        .locale_id = "localeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCustomVocabularyMetadataInput, options: CallOptions) !DescribeCustomVocabularyMetadataOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCustomVocabularyMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botversions/");
    try path_buf.appendSlice(allocator, input.bot_version);
    try path_buf.appendSlice(allocator, "/botlocales/");
    try path_buf.appendSlice(allocator, input.locale_id);
    try path_buf.appendSlice(allocator, "/customvocabulary/DEFAULT/metadata");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCustomVocabularyMetadataOutput {
    const result: DescribeCustomVocabularyMetadataOutput = try aws.json.parseJsonObject(
        DescribeCustomVocabularyMetadataOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
