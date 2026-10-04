const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CrossAccountFilterOption = @import("cross_account_filter_option.zig").CrossAccountFilterOption;
const ModelPackageGroupSortBy = @import("model_package_group_sort_by.zig").ModelPackageGroupSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const ModelPackageGroupSummary = @import("model_package_group_summary.zig").ModelPackageGroupSummary;

pub const ListModelPackageGroupsInput = struct {
    /// A filter that returns only model groups created after the specified time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only model groups created before the specified time.
    creation_time_before: ?i64 = null,

    /// A filter that returns either model groups shared with you or model groups in
    /// your own account. When the value is `CrossAccount`, the results show the
    /// resources made discoverable to you from other accounts. When the value is
    /// `SameAccount` or `null`, the results show resources from your account. The
    /// default is `SameAccount`.
    cross_account_filter_option: ?CrossAccountFilterOption = null,

    /// The maximum number of results to return in the response.
    max_results: ?i32 = null,

    /// A string in the model group name. This filter returns only model groups
    /// whose name contains the specified string.
    name_contains: ?[]const u8 = null,

    /// If the result of the previous `ListModelPackageGroups` request was
    /// truncated, the response includes a `NextToken`. To retrieve the next set of
    /// model groups, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// The field to sort results by. The default is `CreationTime`.
    sort_by: ?ModelPackageGroupSortBy = null,

    /// The sort order for results. The default is `Ascending`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .cross_account_filter_option = "CrossAccountFilterOption",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListModelPackageGroupsOutput = struct {
    /// A list of summaries of the model groups in your Amazon Web Services account.
    model_package_group_summary_list: ?[]const ModelPackageGroupSummary = null,

    /// If the response is truncated, SageMaker returns this token. To retrieve the
    /// next set of model groups, use it in the subsequent request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_package_group_summary_list = "ModelPackageGroupSummaryList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListModelPackageGroupsInput, options: CallOptions) !ListModelPackageGroupsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListModelPackageGroupsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListModelPackageGroups");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListModelPackageGroupsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListModelPackageGroupsOutput, body, allocator);
}
