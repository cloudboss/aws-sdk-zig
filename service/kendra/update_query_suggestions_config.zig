const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AttributeSuggestionsUpdateConfig = @import("attribute_suggestions_update_config.zig").AttributeSuggestionsUpdateConfig;
const Mode = @import("mode.zig").Mode;

pub const UpdateQuerySuggestionsConfigInput = struct {
    /// Configuration information for the document fields/attributes that you want
    /// to base
    /// query suggestions on.
    attribute_suggestions_config: ?AttributeSuggestionsUpdateConfig = null,

    /// `TRUE` to include queries without user information (i.e. all queries,
    /// irrespective of the user), otherwise `FALSE` to only include queries
    /// with user information.
    ///
    /// If you pass user information to Amazon Kendra along with the queries, you
    /// can set this
    /// flag to `FALSE` and instruct Amazon Kendra to only consider queries with
    /// user
    /// information.
    ///
    /// If you set to `FALSE`, Amazon Kendra only considers queries searched at
    /// least
    /// `MinimumQueryCount` times across `MinimumNumberOfQueryingUsers`
    /// unique users for suggestions.
    ///
    /// If you set to `TRUE`, Amazon Kendra ignores all user information and learns
    /// from all queries.
    include_queries_without_user_information: ?bool = null,

    /// The identifier of the index with query suggestions you want to update.
    index_id: []const u8,

    /// The minimum number of unique users who must search a query in order for the
    /// query
    /// to be eligible to suggest to your users.
    ///
    /// Increasing this number might decrease the number of suggestions. However,
    /// this
    /// ensures a query is searched by many users and is truly popular to suggest to
    /// users.
    ///
    /// How you tune this setting depends on your specific needs.
    minimum_number_of_querying_users: ?i32 = null,

    /// The the minimum number of times a query must be searched in order to be
    /// eligible to suggest to your users.
    ///
    /// Decreasing this number increases the number of suggestions. However, this
    /// affects the quality of suggestions as it sets a low bar for a query to be
    /// considered popular to suggest to users.
    ///
    /// How you tune this setting depends on your specific needs.
    minimum_query_count: ?i32 = null,

    /// Set the mode to `ENABLED` or `LEARN_ONLY`.
    ///
    /// By default, Amazon Kendra enables query suggestions.
    /// `LEARN_ONLY` mode allows you to turn off query suggestions.
    /// You can to update this at any time.
    ///
    /// In `LEARN_ONLY` mode, Amazon Kendra continues to learn from new
    /// queries to keep suggestions up to date for when you are ready to
    /// switch to ENABLED mode again.
    mode: ?Mode = null,

    /// How recent your queries are in your query log time window.
    ///
    /// The time window is the number of days from current day to past days.
    ///
    /// By default, Amazon Kendra sets this to 180.
    query_log_look_back_window_in_days: ?i32 = null,

    pub const json_field_names = .{
        .attribute_suggestions_config = "AttributeSuggestionsConfig",
        .include_queries_without_user_information = "IncludeQueriesWithoutUserInformation",
        .index_id = "IndexId",
        .minimum_number_of_querying_users = "MinimumNumberOfQueryingUsers",
        .minimum_query_count = "MinimumQueryCount",
        .mode = "Mode",
        .query_log_look_back_window_in_days = "QueryLogLookBackWindowInDays",
    };
};

pub const UpdateQuerySuggestionsConfigOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateQuerySuggestionsConfigInput, options: CallOptions) !UpdateQuerySuggestionsConfigOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "kendra");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateQuerySuggestionsConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kendra", "kendra", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.UpdateQuerySuggestionsConfig");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateQuerySuggestionsConfigOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
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
    if (std.mem.eql(u8, error_code, "FeaturedResultsConflictException")) {
        return .{ .arena = arena, .kind = .{ .featured_results_conflict_exception = .{
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
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceAlreadyExistException")) {
        return .{ .arena = arena, .kind = .{ .resource_already_exist_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
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
    if (std.mem.eql(u8, error_code, "ResourceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .resource_unavailable_exception = .{
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
