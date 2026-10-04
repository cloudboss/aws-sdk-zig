const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const NotebookInstanceLifecycleConfigSortKey = @import("notebook_instance_lifecycle_config_sort_key.zig").NotebookInstanceLifecycleConfigSortKey;
const NotebookInstanceLifecycleConfigSortOrder = @import("notebook_instance_lifecycle_config_sort_order.zig").NotebookInstanceLifecycleConfigSortOrder;
const NotebookInstanceLifecycleConfigSummary = @import("notebook_instance_lifecycle_config_summary.zig").NotebookInstanceLifecycleConfigSummary;

pub const ListNotebookInstanceLifecycleConfigsInput = struct {
    /// A filter that returns only lifecycle configurations that were created after
    /// the specified time (timestamp).
    creation_time_after: ?i64 = null,

    /// A filter that returns only lifecycle configurations that were created before
    /// the specified time (timestamp).
    creation_time_before: ?i64 = null,

    /// A filter that returns only lifecycle configurations that were modified after
    /// the specified time (timestamp).
    last_modified_time_after: ?i64 = null,

    /// A filter that returns only lifecycle configurations that were modified
    /// before the specified time (timestamp).
    last_modified_time_before: ?i64 = null,

    /// The maximum number of lifecycle configurations to return in the response.
    max_results: ?i32 = null,

    /// A string in the lifecycle configuration name. This filter returns only
    /// lifecycle configurations whose name contains the specified string.
    name_contains: ?[]const u8 = null,

    /// If the result of a `ListNotebookInstanceLifecycleConfigs` request was
    /// truncated, the response includes a `NextToken`. To get the next set of
    /// lifecycle configurations, use the token in the next request.
    next_token: ?[]const u8 = null,

    /// Sorts the list of results. The default is `CreationTime`.
    sort_by: ?NotebookInstanceLifecycleConfigSortKey = null,

    /// The sort order for results.
    sort_order: ?NotebookInstanceLifecycleConfigSortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .last_modified_time_after = "LastModifiedTimeAfter",
        .last_modified_time_before = "LastModifiedTimeBefore",
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListNotebookInstanceLifecycleConfigsOutput = struct {
    /// If the response is truncated, SageMaker AI returns this token. To get the
    /// next set of lifecycle configurations, use it in the next request.
    next_token: ?[]const u8 = null,

    /// An array of `NotebookInstanceLifecycleConfiguration` objects, each listing a
    /// lifecycle configuration.
    notebook_instance_lifecycle_configs: ?[]const NotebookInstanceLifecycleConfigSummary = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .notebook_instance_lifecycle_configs = "NotebookInstanceLifecycleConfigs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListNotebookInstanceLifecycleConfigsInput, options: CallOptions) !ListNotebookInstanceLifecycleConfigsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListNotebookInstanceLifecycleConfigsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListNotebookInstanceLifecycleConfigs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListNotebookInstanceLifecycleConfigsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListNotebookInstanceLifecycleConfigsOutput, body, allocator);
}
