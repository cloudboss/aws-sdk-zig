const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryLanguage = @import("query_language.zig").QueryLanguage;

pub const StartQueryInput = struct {
    /// The end of the time range to query. The range is inclusive, so the specified
    /// end time is
    /// included in the query. Specified as epoch time, the number of seconds since
    /// `January 1,
    /// 1970, 00:00:00 UTC`.
    end_time: i64,

    /// The maximum number of log events to return in the query. If the query string
    /// uses the
    /// `fields` command, only the specified fields and their values are returned.
    /// The
    /// default is 10,000.
    limit: ?i32 = null,

    /// The list of log groups to query. You can include up to 50 log groups.
    ///
    /// You can specify them by the log group name or ARN. If a log group that
    /// you're querying is
    /// in a source account and you're using a monitoring account, you must specify
    /// the ARN of the log
    /// group here. The query definition must also be defined in the monitoring
    /// account.
    ///
    /// If you specify an ARN, use the format
    /// arn:aws:logs:*region*:*account-id*:log-group:*log_group_name*
    /// Don't include an * at the end.
    ///
    /// A `StartQuery` operation must include exactly one of the following
    /// parameters:
    /// `logGroupName`, `logGroupNames`, or `logGroupIdentifiers`.
    /// The exception is queries using the OpenSearch Service SQL query language,
    /// where you specify
    /// the log group names inside the `querystring` instead of here.
    log_group_identifiers: ?[]const []const u8 = null,

    /// The log group on which to perform the query.
    ///
    /// A `StartQuery` operation must include exactly one of the following
    /// parameters: `logGroupName`, `logGroupNames`, or
    /// `logGroupIdentifiers`. The exception is queries using the OpenSearch Service
    /// SQL query language, where you specify the log group names inside the
    /// `querystring` instead of here.
    log_group_name: ?[]const u8 = null,

    /// The list of log groups to be queried. You can include up to 50 log groups.
    ///
    /// A `StartQuery` operation must include exactly one of the following
    /// parameters: `logGroupName`, `logGroupNames`, or
    /// `logGroupIdentifiers`. The exception is queries using the OpenSearch Service
    /// SQL query language, where you specify the log group names inside the
    /// `querystring` instead of here.
    log_group_names: ?[]const []const u8 = null,

    /// Specify the query language to use for this query. The options are Logs
    /// Insights QL,
    /// OpenSearch PPL, and OpenSearch SQL. For more information about the query
    /// languages that
    /// CloudWatch Logs supports, see [Supported query
    /// languages](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_AnalyzeLogData_Languages.html).
    query_language: ?QueryLanguage = null,

    /// The query string to use. For more information, see [CloudWatch Logs Insights
    /// Query
    /// Syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html).
    query_string: []const u8,

    /// The beginning of the time range to query. The range is inclusive, so the
    /// specified start
    /// time is included in the query. Specified as epoch time, the number of
    /// seconds since
    /// `January 1, 1970, 00:00:00 UTC`.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "endTime",
        .limit = "limit",
        .log_group_identifiers = "logGroupIdentifiers",
        .log_group_name = "logGroupName",
        .log_group_names = "logGroupNames",
        .query_language = "queryLanguage",
        .query_string = "queryString",
        .start_time = "startTime",
    };
};

pub const StartQueryOutput = struct {
    /// The unique ID of the query.
    query_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .query_id = "queryId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartQueryInput, options: CallOptions) !StartQueryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartQueryInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.StartQuery");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartQueryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartQueryOutput, body, allocator);
}
