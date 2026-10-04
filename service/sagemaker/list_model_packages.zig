const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ModelApprovalStatus = @import("model_approval_status.zig").ModelApprovalStatus;
const ModelPackageType = @import("model_package_type.zig").ModelPackageType;
const ModelPackageSortBy = @import("model_package_sort_by.zig").ModelPackageSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const ModelPackageSummary = @import("model_package_summary.zig").ModelPackageSummary;

pub const ListModelPackagesInput = struct {
    /// A filter that returns only model packages created after the specified time
    /// (timestamp).
    creation_time_after: ?i64 = null,

    /// A filter that returns only model packages created before the specified time
    /// (timestamp).
    creation_time_before: ?i64 = null,

    /// The maximum number of model packages to return in the response.
    max_results: ?i32 = null,

    /// A filter that returns only the model packages with the specified approval
    /// status.
    model_approval_status: ?ModelApprovalStatus = null,

    /// A filter that returns only model versions that belong to the specified model
    /// group.
    model_package_group_name: ?[]const u8 = null,

    /// A filter that returns only the model packages of the specified type. This
    /// can be one of the following values.
    ///
    /// * `UNVERSIONED` - List only unversioined models. This is the default value
    ///   if no `ModelPackageType` is specified.
    /// * `VERSIONED` - List only versioned models.
    /// * `BOTH` - List both versioned and unversioned models.
    model_package_type: ?ModelPackageType = null,

    /// A string in the model package name. This filter returns only model packages
    /// whose name contains the specified string.
    name_contains: ?[]const u8 = null,

    /// If the response to a previous `ListModelPackages` request was truncated, the
    /// response includes a `NextToken`. To retrieve the next set of model packages,
    /// use the token in the next request.
    next_token: ?[]const u8 = null,

    /// The parameter by which to sort the results. The default is `CreationTime`.
    sort_by: ?ModelPackageSortBy = null,

    /// The sort order for the results. The default is `Ascending`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .max_results = "MaxResults",
        .model_approval_status = "ModelApprovalStatus",
        .model_package_group_name = "ModelPackageGroupName",
        .model_package_type = "ModelPackageType",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListModelPackagesOutput = struct {
    /// An array of `ModelPackageSummary` objects, each of which lists a model
    /// package.
    model_package_summary_list: ?[]const ModelPackageSummary = null,

    /// If the response is truncated, SageMaker returns this token. To retrieve the
    /// next set of model packages, use it in the subsequent request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .model_package_summary_list = "ModelPackageSummaryList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListModelPackagesInput, options: CallOptions) !ListModelPackagesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListModelPackagesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListModelPackages");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListModelPackagesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListModelPackagesOutput, body, allocator);
}
