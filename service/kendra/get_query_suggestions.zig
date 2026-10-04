const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AttributeSuggestionsGetConfig = @import("attribute_suggestions_get_config.zig").AttributeSuggestionsGetConfig;
const SuggestionType = @import("suggestion_type.zig").SuggestionType;
const Suggestion = @import("suggestion.zig").Suggestion;

pub const GetQuerySuggestionsInput = struct {
    /// Configuration information for the document fields/attributes that you
    /// want to base query suggestions on.
    attribute_suggestions_config: ?AttributeSuggestionsGetConfig = null,

    /// The identifier of the index you want to get query suggestions from.
    index_id: []const u8,

    /// The maximum number of query suggestions you want to show
    /// to your users.
    max_suggestions_count: ?i32 = null,

    /// The text of a user's query to generate query suggestions.
    ///
    /// A query is suggested if the query prefix matches
    /// what a user starts to type as their query.
    ///
    /// Amazon Kendra does not show any suggestions if a user
    /// types fewer than two characters or more than 60 characters.
    /// A query must also have at least one search result and contain
    /// at least one word of more than four characters.
    query_text: []const u8,

    /// The suggestions type to base query suggestions on. The suggestion
    /// types are query history or document fields/attributes. You can set
    /// one type or the other.
    ///
    /// If you set query history as your suggestions type, Amazon Kendra
    /// suggests queries relevant to your users based on popular queries in
    /// the query history.
    ///
    /// If you set document fields/attributes as your suggestions type,
    /// Amazon Kendra suggests queries relevant to your users based on the
    /// contents of document fields.
    suggestion_types: ?[]const SuggestionType = null,

    pub const json_field_names = .{
        .attribute_suggestions_config = "AttributeSuggestionsConfig",
        .index_id = "IndexId",
        .max_suggestions_count = "MaxSuggestionsCount",
        .query_text = "QueryText",
        .suggestion_types = "SuggestionTypes",
    };
};

pub const GetQuerySuggestionsOutput = struct {
    /// The identifier for a list of query suggestions for an index.
    query_suggestions_id: ?[]const u8 = null,

    /// A list of query suggestions for an index.
    suggestions: ?[]const Suggestion = null,

    pub const json_field_names = .{
        .query_suggestions_id = "QuerySuggestionsId",
        .suggestions = "Suggestions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQuerySuggestionsInput, options: CallOptions) !GetQuerySuggestionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetQuerySuggestionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSKendraFrontendService.GetQuerySuggestions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQuerySuggestionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetQuerySuggestionsOutput, body, allocator);
}
