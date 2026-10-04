const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FeatureGroupStatus = @import("feature_group_status.zig").FeatureGroupStatus;
const OfflineStoreStatusValue = @import("offline_store_status_value.zig").OfflineStoreStatusValue;
const FeatureGroupSortBy = @import("feature_group_sort_by.zig").FeatureGroupSortBy;
const FeatureGroupSortOrder = @import("feature_group_sort_order.zig").FeatureGroupSortOrder;
const FeatureGroupSummary = @import("feature_group_summary.zig").FeatureGroupSummary;

pub const ListFeatureGroupsInput = struct {
    /// Use this parameter to search for `FeatureGroups`s created after a specific
    /// date and time.
    creation_time_after: ?i64 = null,

    /// Use this parameter to search for `FeatureGroups`s created before a specific
    /// date and time.
    creation_time_before: ?i64 = null,

    /// A `FeatureGroup` status. Filters by `FeatureGroup` status.
    feature_group_status_equals: ?FeatureGroupStatus = null,

    /// The maximum number of results returned by `ListFeatureGroups`.
    max_results: ?i32 = null,

    /// A string that partially matches one or more `FeatureGroup`s names. Filters
    /// `FeatureGroup`s by name.
    name_contains: ?[]const u8 = null,

    /// A token to resume pagination of `ListFeatureGroups` results.
    next_token: ?[]const u8 = null,

    /// An `OfflineStore` status. Filters by `OfflineStore` status.
    offline_store_status_equals: ?OfflineStoreStatusValue = null,

    /// The value on which the feature group list is sorted.
    sort_by: ?FeatureGroupSortBy = null,

    /// The order in which feature groups are listed.
    sort_order: ?FeatureGroupSortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .feature_group_status_equals = "FeatureGroupStatusEquals",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .offline_store_status_equals = "OfflineStoreStatusEquals",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListFeatureGroupsOutput = struct {
    /// A summary of feature groups.
    feature_group_summaries: ?[]const FeatureGroupSummary = null,

    /// A token to resume pagination of `ListFeatureGroups` results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .feature_group_summaries = "FeatureGroupSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListFeatureGroupsInput, options: CallOptions) !ListFeatureGroupsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListFeatureGroupsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListFeatureGroups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListFeatureGroupsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListFeatureGroupsOutput, body, allocator);
}
