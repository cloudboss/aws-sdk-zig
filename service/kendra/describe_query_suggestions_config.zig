const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const errors = @import("errors.zig");
const ServiceError = errors.ServiceError;
const AttributeSuggestionsDescribeConfig = @import("attribute_suggestions_describe_config.zig").AttributeSuggestionsDescribeConfig;
const Mode = @import("mode.zig").Mode;
const QuerySuggestionsStatus = @import("query_suggestions_status.zig").QuerySuggestionsStatus;

pub const DescribeQuerySuggestionsConfigInput = struct {
    /// The identifier of the index with query suggestions that you want to get
    /// information on.
    index_id: []const u8,

    pub const json_field_names = .{
        .index_id = "IndexId",
    };
};

pub const DescribeQuerySuggestionsConfigOutput = struct {
    /// Configuration information for the document fields/attributes that you want
    /// to base query
    /// suggestions on.
    attribute_suggestions_config: ?AttributeSuggestionsDescribeConfig = null,

    /// `TRUE` to use all queries, otherwise use only queries that include
    /// user information to generate the query suggestions.
    include_queries_without_user_information: ?bool = null,

    /// The Unix timestamp when query suggestions for an index was last cleared.
    ///
    /// After you clear suggestions, Amazon Kendra learns new suggestions based
    /// on new queries added to the query log from the time you cleared suggestions.
    /// Amazon Kendra only considers re-occurences of a query from the time you
    /// cleared
    /// suggestions.
    last_clear_time: ?i64 = null,

    /// The Unix timestamp when query suggestions for an index was last updated.
    ///
    /// Amazon Kendra automatically updates suggestions every 24 hours, after you
    /// change a setting or after you apply a [block
    /// list](https://docs.aws.amazon.com/kendra/latest/dg/query-suggestions.html#query-suggestions-blocklist).
    last_suggestions_build_time: ?i64 = null,

    /// The minimum number of unique users who must search a query in
    /// order for the query to be eligible to suggest to your users.
    minimum_number_of_querying_users: ?i32 = null,

    /// The minimum number of times a query must be searched in order for
    /// the query to be eligible to suggest to your users.
    minimum_query_count: ?i32 = null,

    /// Whether query suggestions are currently in
    /// `ENABLED` mode or `LEARN_ONLY` mode.
    ///
    /// By default, Amazon Kendra enables query suggestions.`LEARN_ONLY`
    /// turns off query suggestions for your users. You can change the mode using
    /// the
    /// [UpdateQuerySuggestionsConfig](https://docs.aws.amazon.com/kendra/latest/dg/API_UpdateQuerySuggestionsConfig.html)
    /// API.
    mode: ?Mode = null,

    /// How recent your queries are in your query log time
    /// window (in days).
    query_log_look_back_window_in_days: ?i32 = null,

    /// Whether the status of query suggestions settings is currently
    /// `ACTIVE` or `UPDATING`.
    ///
    /// Active means the current settings apply and Updating means your
    /// changed settings are in the process of applying.
    status: ?QuerySuggestionsStatus = null,

    /// The current total count of query suggestions for an index.
    ///
    /// This count can change when you update your query suggestions settings,
    /// if you filter out certain queries from suggestions using a block list,
    /// and as the query log accumulates more queries for Amazon Kendra to learn
    /// from.
    ///
    /// If the count is much lower than you expected, it could be because Amazon
    /// Kendra
    /// needs more queries in the query history to learn from or your current query
    /// suggestions
    /// settings are too strict.
    total_suggestions_count: ?i32 = null,

    pub const json_field_names = .{
        .attribute_suggestions_config = "AttributeSuggestionsConfig",
        .include_queries_without_user_information = "IncludeQueriesWithoutUserInformation",
        .last_clear_time = "LastClearTime",
        .last_suggestions_build_time = "LastSuggestionsBuildTime",
        .minimum_number_of_querying_users = "MinimumNumberOfQueryingUsers",
        .minimum_query_count = "MinimumQueryCount",
        .mode = "Mode",
        .query_log_look_back_window_in_days = "QueryLogLookBackWindowInDays",
        .status = "Status",
        .total_suggestions_count = "TotalSuggestionsCount",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeQuerySuggestionsConfigInput, options: CallOptions) !DescribeQuerySuggestionsConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch return error.OutOfMemory;
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeQuerySuggestionsConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.DescribeQuerySuggestionsConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeQuerySuggestionsConfigOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeQuerySuggestionsConfigOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.findScalarLast(u8, type_str, '#')) |idx| {
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
        const parsed_error: ?errors.AccessDeniedException = aws.json.parseJsonObject(errors.AccessDeniedException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .access_denied_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        const parsed_error: ?errors.ConflictException = aws.json.parseJsonObject(errors.ConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "FeaturedResultsConflictException")) {
        const parsed_error: ?errors.FeaturedResultsConflictException = aws.json.parseJsonObject(errors.FeaturedResultsConflictException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .featured_results_conflict_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        const parsed_error: ?errors.InternalServerException = aws.json.parseJsonObject(errors.InternalServerException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .internal_server_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        const parsed_error: ?errors.InvalidRequestException = aws.json.parseJsonObject(errors.InvalidRequestException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .invalid_request_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistException")) {
        const parsed_error: ?errors.ResourceAlreadyExistException = aws.json.parseJsonObject(errors.ResourceAlreadyExistException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_already_exist_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        const parsed_error: ?errors.ResourceInUseException = aws.json.parseJsonObject(errors.ResourceInUseException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_in_use_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        const parsed_error: ?errors.ResourceNotFoundException = aws.json.parseJsonObject(errors.ResourceNotFoundException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_not_found_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ResourceUnavailableException")) {
        const parsed_error: ?errors.ResourceUnavailableException = aws.json.parseJsonObject(errors.ResourceUnavailableException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .resource_unavailable_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        const parsed_error: ?errors.ServiceQuotaExceededException = aws.json.parseJsonObject(errors.ServiceQuotaExceededException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        const parsed_error: ?errors.ThrottlingException = aws.json.parseJsonObject(errors.ThrottlingException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .throttling_exception = typed_error } };
        }
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        const parsed_error: ?errors.ValidationException = aws.json.parseJsonObject(errors.ValidationException, body, arena_alloc) catch |err| switch (err) {
            error.OutOfMemory => return error.OutOfMemory,
            else => null,
        };
        if (parsed_error) |parsed| {
            var typed_error = parsed;
            typed_error.message = owned_message;
            typed_error.request_id = owned_request_id;
            return .{ .arena = arena, .kind = .{ .validation_exception = typed_error } };
        }
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
