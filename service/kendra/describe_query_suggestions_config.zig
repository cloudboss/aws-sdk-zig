const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
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
