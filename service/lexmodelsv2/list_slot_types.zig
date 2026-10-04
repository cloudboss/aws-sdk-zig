const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SlotTypeFilter = @import("slot_type_filter.zig").SlotTypeFilter;
const SlotTypeSortBy = @import("slot_type_sort_by.zig").SlotTypeSortBy;
const SlotTypeSummary = @import("slot_type_summary.zig").SlotTypeSummary;

pub const ListSlotTypesInput = struct {
    /// The unique identifier of the bot that contains the slot
    /// types.
    bot_id: []const u8,

    /// The version of the bot that contains the slot type.
    bot_version: []const u8,

    /// Provides the specification of a filter used to limit the slot types
    /// in the response to only those that match the filter specification. You
    /// can only specify one filter and only one string to filter on.
    filters: ?[]const SlotTypeFilter = null,

    /// The identifier of the language and locale of the slot types to list.
    /// The string must match one of the supported locales. For more
    /// information, see [Supported
    /// languages](https://docs.aws.amazon.com/lexv2/latest/dg/how-languages.html).
    locale_id: []const u8,

    /// The maximum number of slot types to return in each page of results.
    /// If there are fewer results than the max page size, only the actual
    /// number of results are returned.
    max_results: ?i32 = null,

    /// If the response from the `ListSlotTypes` operation
    /// contains more results than specified in the `maxResults`
    /// parameter, a token is returned in the response. Use that token in the
    /// `nextToken` parameter to return the next page of
    /// results.
    next_token: ?[]const u8 = null,

    /// Determines the sort order for the response from the
    /// `ListSlotTypes` operation. You can choose to sort by the
    /// slot type name or last updated date in either ascending or descending
    /// order.
    sort_by: ?SlotTypeSortBy = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .filters = "filters",
        .locale_id = "localeId",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort_by = "sortBy",
    };
};

pub const ListSlotTypesOutput = struct {
    /// The identifier of the bot that contains the slot types.
    bot_id: ?[]const u8 = null,

    /// The version of the bot that contains the slot types.
    bot_version: ?[]const u8 = null,

    /// The language and local of the slot types in the list.
    locale_id: ?[]const u8 = null,

    /// A token that indicates whether there are more results to return in a
    /// response to the `ListSlotTypes` operation. If the
    /// `nextToken` field is present, you send the contents as
    /// the `nextToken` parameter of a `ListSlotTypes`
    /// operation request to get the next page of results.
    next_token: ?[]const u8 = null,

    /// Summary information for the slot types that meet the filter criteria
    /// specified in the request. The length of the list is specified in the
    /// `maxResults` parameter of the request. If there are more
    /// slot types available, the `nextToken` field contains a token
    /// to get the next page of results.
    slot_type_summaries: ?[]const SlotTypeSummary = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .locale_id = "localeId",
        .next_token = "nextToken",
        .slot_type_summaries = "slotTypeSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSlotTypesInput, options: CallOptions) !ListSlotTypesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSlotTypesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("models-v2-lex", "Lex Models V2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/bots/");
    try path_buf.appendSlice(allocator, input.bot_id);
    try path_buf.appendSlice(allocator, "/botversions/");
    try path_buf.appendSlice(allocator, input.bot_version);
    try path_buf.appendSlice(allocator, "/botlocales/");
    try path_buf.appendSlice(allocator, input.locale_id);
    try path_buf.appendSlice(allocator, "/slottypes");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sort_by) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortBy\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSlotTypesOutput {
    var result: ListSlotTypesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListSlotTypesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
