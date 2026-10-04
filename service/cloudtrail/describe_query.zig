const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeliveryStatus = @import("delivery_status.zig").DeliveryStatus;
const QueryStatisticsForDescribeQuery = @import("query_statistics_for_describe_query.zig").QueryStatisticsForDescribeQuery;
const QueryStatus = @import("query_status.zig").QueryStatus;

pub const DescribeQueryInput = struct {
    /// The ARN (or the ID suffix of the ARN) of an event data store on which the
    /// specified
    /// query was run.
    event_data_store: ?[]const u8 = null,

    /// The account ID of the event data store owner.
    event_data_store_owner_account_id: ?[]const u8 = null,

    /// The alias that identifies a query template.
    query_alias: ?[]const u8 = null,

    /// The query ID.
    query_id: ?[]const u8 = null,

    /// The ID of the dashboard refresh.
    refresh_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .event_data_store = "EventDataStore",
        .event_data_store_owner_account_id = "EventDataStoreOwnerAccountId",
        .query_alias = "QueryAlias",
        .query_id = "QueryId",
        .refresh_id = "RefreshId",
    };
};

pub const DescribeQueryOutput = struct {
    /// The URI for the S3 bucket where CloudTrail delivered query results, if
    /// applicable.
    delivery_s3_uri: ?[]const u8 = null,

    /// The delivery status.
    delivery_status: ?DeliveryStatus = null,

    /// The error message returned if a query failed.
    error_message: ?[]const u8 = null,

    /// The account ID of the event data store owner.
    event_data_store_owner_account_id: ?[]const u8 = null,

    /// The prompt used for a generated query. For information about generated
    /// queries, see
    /// [Create CloudTrail Lake queries from natural language
    /// prompts](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/lake-query-generator.html)
    /// in the *CloudTrail * user guide.
    prompt: ?[]const u8 = null,

    /// The ID of the query.
    query_id: ?[]const u8 = null,

    /// Metadata about a query, including the number of events that were matched,
    /// the total
    /// number of events scanned, the query run time in milliseconds, and the
    /// query's creation
    /// time.
    query_statistics: ?QueryStatisticsForDescribeQuery = null,

    /// The status of a query. Values for `QueryStatus` include `QUEUED`,
    /// `RUNNING`, `FINISHED`, `FAILED`,
    /// `TIMED_OUT`, or `CANCELLED`
    query_status: ?QueryStatus = null,

    /// The SQL code of a query.
    query_string: ?[]const u8 = null,

    pub const json_field_names = .{
        .delivery_s3_uri = "DeliveryS3Uri",
        .delivery_status = "DeliveryStatus",
        .error_message = "ErrorMessage",
        .event_data_store_owner_account_id = "EventDataStoreOwnerAccountId",
        .prompt = "Prompt",
        .query_id = "QueryId",
        .query_statistics = "QueryStatistics",
        .query_status = "QueryStatus",
        .query_string = "QueryString",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeQueryInput, options: CallOptions) !DescribeQueryOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeQueryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.DescribeQuery");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeQueryOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeQueryOutput, body, allocator);
}
