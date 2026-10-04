const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryLanguage = @import("query_language.zig").QueryLanguage;
const ResultField = @import("result_field.zig").ResultField;
const QueryStatistics = @import("query_statistics.zig").QueryStatistics;
const QueryStatus = @import("query_status.zig").QueryStatus;

pub const GetQueryResultsInput = struct {
    /// The maximum number of log events to return in the response. The maximum is
    /// 10,000 log events.
    max_items: ?i32 = null,

    /// The token for the next set of items to return. The token expires after 1
    /// hour.
    next_token: ?[]const u8 = null,

    /// The ID number of the query.
    query_id: []const u8,

    pub const json_field_names = .{
        .max_items = "maxItems",
        .next_token = "nextToken",
        .query_id = "queryId",
    };
};

pub const GetQueryResultsOutput = struct {
    /// If you associated an KMS key with the CloudWatch Logs Insights
    /// query results in this account, this field displays the ARN of the key that's
    /// used to encrypt
    /// the query results when
    /// [StartQuery](https://docs.aws.amazon.com/AmazonCloudWatchLogs/latest/APIReference/API_StartQuery.html) stores
    /// them.
    encryption_key: ?[]const u8 = null,

    /// If there are more log events remaining in the results, the response includes
    /// a
    /// `nextToken`. You can use this token in a subsequent `GetQueryResults`
    /// request to get the next set of results.
    next_token: ?[]const u8 = null,

    /// The query language used for this query. For more information about the query
    /// languages
    /// that CloudWatch Logs supports, see [Supported query
    /// languages](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_AnalyzeLogData_Languages.html).
    query_language: ?QueryLanguage = null,

    /// The log events that matched the query criteria during the most recent time
    /// it ran.
    ///
    /// The `results` value is an array of arrays. Each log event is one object in
    /// the
    /// top-level array. Each of these log event objects is an array of
    /// `field`/`value` pairs.
    results: ?[]const []const ResultField = null,

    /// Includes the number of log events scanned by the query, the number of log
    /// events that
    /// matched the query criteria, and the total number of bytes in the scanned log
    /// events. These
    /// values reflect the full raw results of the query.
    statistics: ?QueryStatistics = null,

    /// The status of the most recent running of the query. Possible values are
    /// `Cancelled`, `Complete`, `Failed`, `Running`,
    /// `Scheduled`, `Timeout`, and `Unknown`.
    ///
    /// Queries time out after 60 minutes of runtime. To avoid having your queries
    /// time out,
    /// reduce the time range being searched or partition your query into a number
    /// of queries.
    status: ?QueryStatus = null,

    pub const json_field_names = .{
        .encryption_key = "encryptionKey",
        .next_token = "nextToken",
        .query_language = "queryLanguage",
        .results = "results",
        .statistics = "statistics",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetQueryResultsInput, options: CallOptions) !GetQueryResultsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetQueryResultsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.GetQueryResults");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetQueryResultsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetQueryResultsOutput, body, allocator);
}
