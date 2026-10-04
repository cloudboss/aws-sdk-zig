const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SortLineageGroupsBy = @import("sort_lineage_groups_by.zig").SortLineageGroupsBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const LineageGroupSummary = @import("lineage_group_summary.zig").LineageGroupSummary;

pub const ListLineageGroupsInput = struct {
    /// A timestamp to filter against lineage groups created after a certain point
    /// in time.
    created_after: ?i64 = null,

    /// A timestamp to filter against lineage groups created before a certain point
    /// in time.
    created_before: ?i64 = null,

    /// The maximum number of endpoints to return in the response. This value
    /// defaults to 10.
    max_results: ?i32 = null,

    /// If the response is truncated, SageMaker returns this token. To retrieve the
    /// next set of algorithms, use it in the subsequent request.
    next_token: ?[]const u8 = null,

    /// The parameter by which to sort the results. The default is `CreationTime`.
    sort_by: ?SortLineageGroupsBy = null,

    /// The sort order for the results. The default is `Ascending`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListLineageGroupsOutput = struct {
    /// A list of lineage groups and their properties.
    lineage_group_summaries: ?[]const LineageGroupSummary = null,

    /// If the response is truncated, SageMaker returns this token. To retrieve the
    /// next set of algorithms, use it in the subsequent request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .lineage_group_summaries = "LineageGroupSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListLineageGroupsInput, options: CallOptions) !ListLineageGroupsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListLineageGroupsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListLineageGroups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListLineageGroupsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListLineageGroupsOutput, body, allocator);
}
