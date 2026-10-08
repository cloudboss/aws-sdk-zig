const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryInsights = @import("query_insights.zig").QueryInsights;
const ColumnInfo = @import("column_info.zig").ColumnInfo;
const QueryInsightsResponse = @import("query_insights_response.zig").QueryInsightsResponse;
const QueryStatus = @import("query_status.zig").QueryStatus;
const Row = @import("row.zig").Row;

pub const QueryInput = struct {
    /// Unique, case-sensitive string of up to 64 ASCII characters specified when a
    /// `Query` request is made. Providing a `ClientToken` makes the
    /// call to `Query`
    /// *idempotent*. This means that running the same query repeatedly will
    /// produce the same result. In other words, making multiple identical `Query`
    /// requests has the same effect as making a single request. When using
    /// `ClientToken` in a query, note the following:
    ///
    /// * If the Query API is instantiated without a `ClientToken`, the
    /// Query SDK generates a `ClientToken` on your behalf.
    ///
    /// * If the `Query` invocation only contains the
    /// `ClientToken` but does not include a `NextToken`, that
    /// invocation of `Query` is assumed to be a new query run.
    ///
    /// * If the invocation contains `NextToken`, that particular invocation
    /// is assumed to be a subsequent invocation of a prior call to the Query API,
    /// and a
    /// result set is returned.
    ///
    /// * After 4 hours, any request with the same `ClientToken` is treated
    /// as a new request.
    client_token: ?[]const u8 = null,

    /// The total number of rows to be returned in the `Query` output. The initial
    /// run of `Query` with a `MaxRows` value specified will return the
    /// result set of the query in two cases:
    ///
    /// * The size of the result is less than `1MB`.
    ///
    /// * The number of rows in the result set is less than the value of
    /// `maxRows`.
    ///
    /// Otherwise, the initial invocation of `Query` only returns a
    /// `NextToken`, which can then be used in subsequent calls to fetch the
    /// result set. To resume pagination, provide the `NextToken` value in the
    /// subsequent command.
    ///
    /// If the row size is large (e.g. a row has many columns), Timestream may
    /// return
    /// fewer rows to keep the response size from exceeding the 1 MB limit. If
    /// `MaxRows` is not provided, Timestream will send the necessary
    /// number of rows to meet the 1 MB limit.
    max_rows: ?i32 = null,

    /// A pagination token used to return a set of results. When the `Query` API
    /// is invoked using `NextToken`, that particular invocation is assumed to be a
    /// subsequent invocation of a prior call to `Query`, and a result set is
    /// returned. However, if the `Query` invocation only contains the
    /// `ClientToken`, that invocation of `Query` is assumed to be a
    /// new query run.
    ///
    /// Note the following when using NextToken in a query:
    ///
    /// * A pagination token can be used for up to five `Query` invocations,
    /// OR for a duration of up to 1 hour – whichever comes first.
    ///
    /// * Using the same `NextToken` will return the same set of records. To
    /// keep paginating through the result set, you must to use the most recent
    /// `nextToken`.
    ///
    /// * Suppose a `Query` invocation returns two `NextToken`
    /// values, `TokenA` and `TokenB`. If `TokenB` is
    /// used in a subsequent `Query` invocation, then `TokenA` is
    /// invalidated and cannot be reused.
    ///
    /// * To request a previous result set from a query after pagination has begun,
    ///   you
    /// must re-invoke the Query API.
    ///
    /// * The latest `NextToken` should be used to paginate until
    /// `null` is returned, at which point a new `NextToken`
    /// should be used.
    ///
    /// * If the IAM principal of the query initiator and the result reader are not
    ///   the
    /// same and/or the query initiator and the result reader do not have the same
    /// query
    /// string in the query requests, the query will fail with an `Invalid
    /// pagination token` error.
    next_token: ?[]const u8 = null,

    /// Encapsulates settings for enabling `QueryInsights`.
    ///
    /// Enabling `QueryInsights` returns insights and metrics in addition to query
    /// results for the query that you executed. You can use `QueryInsights` to tune
    /// your query performance.
    query_insights: ?QueryInsights = null,

    /// The query to be run by Timestream.
    query_string: []const u8,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .max_rows = "MaxRows",
        .next_token = "NextToken",
        .query_insights = "QueryInsights",
        .query_string = "QueryString",
    };
};

pub const QueryOutput = struct {
    /// The column data types of the returned result set.
    column_info: ?[]const ColumnInfo = null,

    /// A pagination token that can be used again on a `Query` call to get the
    /// next set of results.
    next_token: ?[]const u8 = null,

    /// A unique ID for the given query.
    query_id: []const u8,

    /// Encapsulates `QueryInsights` containing insights and metrics related to the
    /// query that you executed.
    query_insights_response: ?QueryInsightsResponse = null,

    /// Information about the status of the query, including progress and bytes
    /// scanned.
    query_status: ?QueryStatus = null,

    /// The result set rows returned by the query.
    rows: ?[]const Row = null,

    pub const json_field_names = .{
        .column_info = "ColumnInfo",
        .next_token = "NextToken",
        .query_id = "QueryId",
        .query_insights_response = "QueryInsightsResponse",
        .query_status = "QueryStatus",
        .rows = "Rows",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: QueryInput, options: CallOptions) !QueryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "timestream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: QueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("query.timestream", "Timestream Query", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Timestream_20181101.Query");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !QueryOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(QueryOutput, body, allocator);
}
