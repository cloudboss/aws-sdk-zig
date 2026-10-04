const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContributorInsightsMode = @import("contributor_insights_mode.zig").ContributorInsightsMode;
const ContributorInsightsStatus = @import("contributor_insights_status.zig").ContributorInsightsStatus;
const FailureException = @import("failure_exception.zig").FailureException;

pub const DescribeContributorInsightsInput = struct {
    /// The name of the global secondary index to describe, if applicable.
    index_name: ?[]const u8 = null,

    /// The name of the table to describe. You can also provide the Amazon Resource
    /// Name (ARN) of the table in
    /// this parameter.
    table_name: []const u8,

    pub const json_field_names = .{
        .index_name = "IndexName",
        .table_name = "TableName",
    };
};

pub const DescribeContributorInsightsOutput = struct {
    /// The mode of CloudWatch Contributor Insights for DynamoDB that determines
    /// which events are emitted. Can be set to track all access and throttled
    /// events or throttled
    /// events only.
    contributor_insights_mode: ?ContributorInsightsMode = null,

    /// List of names of the associated contributor insights rules.
    contributor_insights_rule_list: ?[]const []const u8 = null,

    /// Current status of contributor insights.
    contributor_insights_status: ?ContributorInsightsStatus = null,

    /// Returns information about the last failure that was encountered.
    ///
    /// The most common exceptions for a FAILED status are:
    ///
    /// * LimitExceededException - Per-account Amazon CloudWatch Contributor
    ///   Insights
    /// rule limit reached. Please disable Contributor Insights for other
    /// tables/indexes
    /// OR disable Contributor Insights rules before retrying.
    ///
    /// * AccessDeniedException - Amazon CloudWatch Contributor Insights rules
    ///   cannot be
    /// modified due to insufficient permissions.
    ///
    /// * AccessDeniedException - Failed to create service-linked role for
    ///   Contributor
    /// Insights due to insufficient permissions.
    ///
    /// * InternalServerError - Failed to create Amazon CloudWatch Contributor
    ///   Insights
    /// rules. Please retry request.
    failure_exception: ?FailureException = null,

    /// The name of the global secondary index being described.
    index_name: ?[]const u8 = null,

    /// Timestamp of the last time the status was changed.
    last_update_date_time: ?i64 = null,

    /// The name of the table being described.
    table_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .contributor_insights_mode = "ContributorInsightsMode",
        .contributor_insights_rule_list = "ContributorInsightsRuleList",
        .contributor_insights_status = "ContributorInsightsStatus",
        .failure_exception = "FailureException",
        .index_name = "IndexName",
        .last_update_date_time = "LastUpdateDateTime",
        .table_name = "TableName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeContributorInsightsInput, options: CallOptions) !DescribeContributorInsightsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dynamodb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeContributorInsightsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dynamodb", "DynamoDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "DynamoDB_20120810.DescribeContributorInsights");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeContributorInsightsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeContributorInsightsOutput, body, allocator);
}
