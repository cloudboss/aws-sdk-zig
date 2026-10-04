const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceFilter = @import("data_source_filter.zig").DataSourceFilter;
const ListAggregateLogGroupSummariesGroupBy = @import("list_aggregate_log_group_summaries_group_by.zig").ListAggregateLogGroupSummariesGroupBy;
const LogGroupClass = @import("log_group_class.zig").LogGroupClass;
const AggregateLogGroupSummary = @import("aggregate_log_group_summary.zig").AggregateLogGroupSummary;

pub const ListAggregateLogGroupSummariesInput = struct {
    /// When `includeLinkedAccounts` is set to `true`, use this parameter to
    /// specify the list of accounts to search. You can specify as many as 20
    /// account IDs in the
    /// array.
    account_identifiers: ?[]const []const u8 = null,

    /// Filters the results by data source characteristics to include only log
    /// groups associated
    /// with the specified data sources.
    data_sources: ?[]const DataSourceFilter = null,

    /// Specifies how to group the log groups in the summary.
    group_by: ListAggregateLogGroupSummariesGroupBy,

    /// If you are using a monitoring account, set this to `true` to have the
    /// operation
    /// return log groups in the accounts listed in `accountIdentifiers`.
    ///
    /// If this parameter is set to `true` and `accountIdentifiers` contains
    /// a null value, the operation returns all log groups in the monitoring account
    /// and all log
    /// groups in all source accounts that are linked to the monitoring account.
    ///
    /// The default for this parameter is `false`.
    include_linked_accounts: ?bool = null,

    /// The maximum number of aggregated summaries to return. If you omit this
    /// parameter, the
    /// default is up to 50 aggregated summaries.
    limit: ?i32 = null,

    /// Filters the results by log group class to include only log groups of the
    /// specified
    /// class.
    log_group_class: ?LogGroupClass = null,

    /// Use this parameter to limit the returned log groups to only those with names
    /// that match
    /// the pattern that you specify. This parameter is a regular expression that
    /// can match prefixes
    /// and substrings, and supports wildcard matching and matching multiple
    /// patterns, as in the
    /// following examples.
    ///
    /// * Use `^` to match log group names by prefix.
    ///
    /// * For a substring match, specify the string to match. All matches are case
    /// sensitive
    ///
    /// * To match multiple patterns, separate them with a `|` as in the example
    /// `^/aws/lambda|discovery`
    ///
    /// You can specify as many as five different regular expression patterns in
    /// this field, each
    /// of which must be between 3 and 24 characters. You can include the `^` symbol
    /// as
    /// many as five times, and include the `|` symbol as many as four times.
    log_group_name_pattern: ?[]const u8 = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_identifiers = "accountIdentifiers",
        .data_sources = "dataSources",
        .group_by = "groupBy",
        .include_linked_accounts = "includeLinkedAccounts",
        .limit = "limit",
        .log_group_class = "logGroupClass",
        .log_group_name_pattern = "logGroupNamePattern",
        .next_token = "nextToken",
    };
};

pub const ListAggregateLogGroupSummariesOutput = struct {
    /// The list of aggregate log group summaries grouped by the specified data
    /// source
    /// characteristics.
    aggregate_log_group_summaries: ?[]const AggregateLogGroupSummary = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .aggregate_log_group_summaries = "aggregateLogGroupSummaries",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAggregateLogGroupSummariesInput, options: CallOptions) !ListAggregateLogGroupSummariesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAggregateLogGroupSummariesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.ListAggregateLogGroupSummaries");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAggregateLogGroupSummariesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAggregateLogGroupSummariesOutput, body, allocator);
}
