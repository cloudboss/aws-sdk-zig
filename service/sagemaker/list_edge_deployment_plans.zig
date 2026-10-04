const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListEdgeDeploymentPlansSortBy = @import("list_edge_deployment_plans_sort_by.zig").ListEdgeDeploymentPlansSortBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const EdgeDeploymentPlanSummary = @import("edge_deployment_plan_summary.zig").EdgeDeploymentPlanSummary;

pub const ListEdgeDeploymentPlansInput = struct {
    /// Selects edge deployment plans created after this time.
    creation_time_after: ?i64 = null,

    /// Selects edge deployment plans created before this time.
    creation_time_before: ?i64 = null,

    /// Selects edge deployment plans with a device fleet name containing this name.
    device_fleet_name_contains: ?[]const u8 = null,

    /// Selects edge deployment plans that were last updated after this time.
    last_modified_time_after: ?i64 = null,

    /// Selects edge deployment plans that were last updated before this time.
    last_modified_time_before: ?i64 = null,

    /// The maximum number of results to select (50 by default).
    max_results: ?i32 = null,

    /// Selects edge deployment plans with names containing this name.
    name_contains: ?[]const u8 = null,

    /// The response from the last list when returning a list large enough to need
    /// tokening.
    next_token: ?[]const u8 = null,

    /// The column by which to sort the edge deployment plans. Can be one of `NAME`,
    /// `DEVICEFLEETNAME`, `CREATIONTIME`, `LASTMODIFIEDTIME`.
    sort_by: ?ListEdgeDeploymentPlansSortBy = null,

    /// The direction of the sorting (ascending or descending).
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .device_fleet_name_contains = "DeviceFleetNameContains",
        .last_modified_time_after = "LastModifiedTimeAfter",
        .last_modified_time_before = "LastModifiedTimeBefore",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListEdgeDeploymentPlansOutput = struct {
    /// List of summaries of edge deployment plans.
    edge_deployment_plan_summaries: ?[]const EdgeDeploymentPlanSummary = null,

    /// The token to use when calling the next page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .edge_deployment_plan_summaries = "EdgeDeploymentPlanSummaries",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListEdgeDeploymentPlansInput, options: CallOptions) !ListEdgeDeploymentPlansOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListEdgeDeploymentPlansInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListEdgeDeploymentPlans");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListEdgeDeploymentPlansOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListEdgeDeploymentPlansOutput, body, allocator);
}
