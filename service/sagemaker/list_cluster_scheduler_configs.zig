const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortClusterSchedulerConfigBy = @import("sort_cluster_scheduler_config_by.zig").SortClusterSchedulerConfigBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const SchedulerResourceStatus = @import("scheduler_resource_status.zig").SchedulerResourceStatus;
const ClusterSchedulerConfigSummary = @import("cluster_scheduler_config_summary.zig").ClusterSchedulerConfigSummary;

pub const ListClusterSchedulerConfigsInput = struct {
    /// Filter for ARN of the cluster.
    cluster_arn: ?[]const u8 = null,

    /// Filter for after this creation time. The input for this parameter is a Unix
    /// timestamp. To convert a date and time into a Unix timestamp, see
    /// [EpochConverter](https://www.epochconverter.com/).
    created_after: ?i64 = null,

    /// Filter for before this creation time. The input for this parameter is a Unix
    /// timestamp. To convert a date and time into a Unix timestamp, see
    /// [EpochConverter](https://www.epochconverter.com/).
    created_before: ?i64 = null,

    /// The maximum number of cluster policies to list.
    max_results: ?i32 = null,

    /// Filter for name containing this string.
    name_contains: ?[]const u8 = null,

    /// If the previous response was truncated, you will receive this token. Use it
    /// in your next request to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// Filter for sorting the list by a given value. For example, sort by name,
    /// creation time, or status.
    sort_by: ?SortClusterSchedulerConfigBy = null,

    /// The order of the list. By default, listed in `Descending` order according to
    /// by `SortBy`. To change the list order, you can specify `SortOrder` to be
    /// `Ascending`.
    sort_order: ?SortOrder = null,

    /// Filter for status.
    status: ?SchedulerResourceStatus = null,

    pub const json_field_names = .{
        .cluster_arn = "ClusterArn",
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .status = "Status",
    };
};

pub const ListClusterSchedulerConfigsOutput = struct {
    /// Summaries of the cluster policies.
    cluster_scheduler_config_summaries: ?[]const ClusterSchedulerConfigSummary = null,

    /// If the previous response was truncated, you will receive this token. Use it
    /// in your next request to receive the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_scheduler_config_summaries = "ClusterSchedulerConfigSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListClusterSchedulerConfigsInput, options: CallOptions) !ListClusterSchedulerConfigsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListClusterSchedulerConfigsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListClusterSchedulerConfigs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListClusterSchedulerConfigsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListClusterSchedulerConfigsOutput, body, allocator);
}
