const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kendra", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateQuerySuggestionsConfigInput, config: *aws.Config) !aws.http.Request {
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
