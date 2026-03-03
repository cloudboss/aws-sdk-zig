const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ImportFilter = @import("import_filter.zig").ImportFilter;
const ImportSortBy = @import("import_sort_by.zig").ImportSortBy;
const ImportSummary = @import("import_summary.zig").ImportSummary;

pub const ListImportsInput = struct {
    /// The unique identifier that Amazon Lex assigned to the bot.
    bot_id: ?[]const u8 = null,

    /// The version of the bot to list imports for.
    bot_version: ?[]const u8 = null,

    /// Provides the specification of a filter used to limit the bots in the
    /// response to only those that match the filter specification. You can
    /// only specify one filter and one string to filter on.
    filters: ?[]const ImportFilter = null,

    /// Specifies the locale that should be present in the list. If you
    /// don't specify a resource type in the `filters` parameter,
    /// the list contains both bot locales and custom vocabularies.
    locale_id: ?[]const u8 = null,

    /// The maximum number of imports to return in each page of results. If
    /// there are fewer results than the max page size, only the actual number
    /// of results are returned.
    max_results: ?i32 = null,

    /// If the response from the `ListImports` operation contains
    /// more results than specified in the `maxResults` parameter, a
    /// token is returned in the response.
    ///
    /// Use the returned token in the `nextToken` parameter of a
    /// `ListImports` request to return the next page of results.
    /// For a complete set of results, call the `ListImports`
    /// operation until the `nextToken` returned in the response is
    /// null.
    next_token: ?[]const u8 = null,

    /// Determines the field that the list of imports is sorted by. You can
    /// sort by the `LastUpdatedDateTime` field in ascending or
    /// descending order.
    sort_by: ?ImportSortBy = null,

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

pub const ListImportsOutput = struct {
    /// The unique identifier assigned by Amazon Lex to the bot.
    bot_id: ?[]const u8 = null,

    /// The version of the bot that was imported. It will always be
    /// `DRAFT`.
    bot_version: ?[]const u8 = null,

    /// Summary information for the imports that meet the filter criteria
    /// specified in the request. The length of the list is specified in the
    /// `maxResults` parameter. If there are more imports
    /// available, the `nextToken` field contains a token to get the
    /// next page of results.
    import_summaries: ?[]const ImportSummary = null,

    /// The locale specified in the request.
    locale_id: ?[]const u8 = null,

    /// A token that indicates whether there are more results to return in a
    /// response to the `ListImports` operation. If the
    /// `nextToken` field is present, you send the contents as
    /// the `nextToken` parameter of a `ListImports`
    /// operation request to get the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .bot_id = "botId",
        .bot_version = "botVersion",
        .import_summaries = "importSummaries",
        .locale_id = "localeId",
        .next_token = "nextToken",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListImportsInput, options: Options) !ListImportsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "lexmodelsv2");

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListImportsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lexmodelsv2", "Lex Models V2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/imports";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.bot_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"botId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.bot_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"botVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.locale_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"localeId\":");
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListImportsOutput {
    var result: ListImportsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListImportsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "PreconditionFailedException")) {
        return .{ .arena = arena, .kind = .{ .precondition_failed_exception = .{
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
