const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomVocabularyItem = @import("custom_vocabulary_item.zig").CustomVocabularyItem;
const FailedCustomVocabularyItem = @import("failed_custom_vocabulary_item.zig").FailedCustomVocabularyItem;

pub const BatchUpdateCustomVocabularyItemInput = struct {
    /// The identifier of the bot associated with this custom vocabulary
    bot_id: []const u8,

    /// The identifier of the version of the bot associated with this custom
    /// vocabulary.
    bot_version: []const u8,

    /// A list of custom vocabulary items with updated fields. Each entry must
    /// contain a phrase
    /// and can optionally contain a displayAs and/or a weight.
    custom_vocabulary_item_list: []const CustomVocabularyItem,

    /// The identifier of the language and locale where this custom vocabulary
    /// is used. The string must match one of the supported locales. For more
    /// information, see [ Supported Languages
    /// ](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: []const u8,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .custom_vocabulary_item_list = "customVocabularyItemList",
        .locale_id = "localeId",
    };
};

pub const BatchUpdateCustomVocabularyItemOutput = struct {
    /// The identifier of the bot associated with this custom vocabulary.
    bot_id: ?[]const u8 = null,

    /// The identifier of the version of the bot associated with this custom
    /// vocabulary.
    bot_version: ?[]const u8 = null,

    /// A list of custom vocabulary items that failed to update during the
    /// operation.
    /// The reason for the error is contained within each error object.
    errors: ?[]const FailedCustomVocabularyItem = null,

    /// The identifier of the language and locale where this custom vocabulary
    /// is used. The string must match one of the supported locales. For more
    /// information, see [ Supported Languages
    /// ](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: ?[]const u8 = null,

    /// A list of custom vocabulary items that were
    /// successfully updated during the operation.
    resources: ?[]const CustomVocabularyItem = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .errors = "errors",
        .locale_id = "localeId",
        .resources = "resources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchUpdateCustomVocabularyItemInput, options: CallOptions) !BatchUpdateCustomVocabularyItemOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchUpdateCustomVocabularyItemInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botversions/");
    try path_buf.appendSlice(allocator, input.bot_version);
    try path_buf.appendSlice(allocator, "/botlocales/");
    try path_buf.appendSlice(allocator, input.locale_id);
    try path_buf.appendSlice(allocator, "/customvocabulary/DEFAULT/batchupdate");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"customVocabularyItemList\":");
    try aws.json.writeValue(@TypeOf(input.custom_vocabulary_item_list), input.custom_vocabulary_item_list, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchUpdateCustomVocabularyItemOutput {
    var result: BatchUpdateCustomVocabularyItemOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchUpdateCustomVocabularyItemOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
