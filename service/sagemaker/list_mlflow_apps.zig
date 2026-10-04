const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountDefaultStatus = @import("account_default_status.zig").AccountDefaultStatus;
const SortMlflowAppBy = @import("sort_mlflow_app_by.zig").SortMlflowAppBy;
const SortOrder = @import("sort_order.zig").SortOrder;
const MlflowAppStatus = @import("mlflow_app_status.zig").MlflowAppStatus;
const MlflowAppSummary = @import("mlflow_app_summary.zig").MlflowAppSummary;

pub const ListMlflowAppsInput = struct {
    /// Filter for MLflow Apps with the specified `AccountDefaultStatus`.
    account_default_status: ?AccountDefaultStatus = null,

    /// Use the `CreatedAfter` filter to only list MLflow Apps created after a
    /// specific date and time. Listed MLflow Apps are shown with a date and time
    /// such as `"2024-03-16T01:46:56+00:00"`. The `CreatedAfter` parameter takes in
    /// a Unix timestamp.
    created_after: ?i64 = null,

    /// Use the `CreatedBefore` filter to only list MLflow Apps created before a
    /// specific date and time. Listed MLflow Apps are shown with a date and time
    /// such as `"2024-03-16T01:46:56+00:00"`. The `CreatedAfter` parameter takes in
    /// a Unix timestamp.
    created_before: ?i64 = null,

    /// Filter for MLflow Apps with the specified default SageMaker Domain ID.
    default_for_domain_id: ?[]const u8 = null,

    /// The maximum number of MLflow Apps to list.
    max_results: ?i32 = null,

    /// Filter for Mlflow Apps with the specified version.
    mlflow_version: ?[]const u8 = null,

    /// If the previous response was truncated, use this token in your next request
    /// to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// Filter for MLflow Apps sorting by name, creation time, or creation status.
    sort_by: ?SortMlflowAppBy = null,

    /// Change the order of the listed MLflow Apps. By default, MLflow Apps are
    /// listed in `Descending` order by creation time. To change the list order,
    /// specify `SortOrder` to be `Ascending`.
    sort_order: ?SortOrder = null,

    /// Filter for Mlflow apps with a specific creation status.
    status: ?MlflowAppStatus = null,

    pub const json_field_names = .{
        .account_default_status = "AccountDefaultStatus",
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
        .default_for_domain_id = "DefaultForDomainId",
        .max_results = "MaxResults",
        .mlflow_version = "MlflowVersion",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
        .status = "Status",
    };
};

pub const ListMlflowAppsOutput = struct {
    /// If the previous response was truncated, you will receive this token. Use it
    /// in your next request to receive the next set of results.
    next_token: ?[]const u8 = null,

    /// A list of MLflow Apps according to chosen filters.
    summaries: ?[]const MlflowAppSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .summaries = "Summaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMlflowAppsInput, options: CallOptions) !ListMlflowAppsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMlflowAppsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListMlflowApps");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMlflowAppsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListMlflowAppsOutput, body, allocator);
}
