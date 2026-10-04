const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AppImageConfigSortKey = @import("app_image_config_sort_key.zig").AppImageConfigSortKey;
const SortOrder = @import("sort_order.zig").SortOrder;
const AppImageConfigDetails = @import("app_image_config_details.zig").AppImageConfigDetails;

pub const ListAppImageConfigsInput = struct {
    /// A filter that returns only AppImageConfigs created on or after the specified
    /// time.
    creation_time_after: ?i64 = null,

    /// A filter that returns only AppImageConfigs created on or before the
    /// specified time.
    creation_time_before: ?i64 = null,

    /// The total number of items to return in the response. If the total number of
    /// items available is more than the value specified, a `NextToken` is provided
    /// in the response. To resume pagination, provide the `NextToken` value in the
    /// as part of a subsequent call. The default value is 10.
    max_results: ?i32 = null,

    /// A filter that returns only AppImageConfigs modified on or after the
    /// specified time.
    modified_time_after: ?i64 = null,

    /// A filter that returns only AppImageConfigs modified on or before the
    /// specified time.
    modified_time_before: ?i64 = null,

    /// A filter that returns only AppImageConfigs whose name contains the specified
    /// string.
    name_contains: ?[]const u8 = null,

    /// If the previous call to `ListImages` didn't return the full set of
    /// AppImageConfigs, the call returns a token for getting the next set of
    /// AppImageConfigs.
    next_token: ?[]const u8 = null,

    /// The property used to sort results. The default value is `CreationTime`.
    sort_by: ?AppImageConfigSortKey = null,

    /// The sort order. The default value is `Descending`.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .creation_time_after = "CreationTimeAfter",
        .creation_time_before = "CreationTimeBefore",
        .max_results = "MaxResults",
        .modified_time_after = "ModifiedTimeAfter",
        .modified_time_before = "ModifiedTimeBefore",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListAppImageConfigsOutput = struct {
    /// A list of AppImageConfigs and their properties.
    app_image_configs: ?[]const AppImageConfigDetails = null,

    /// A token for getting the next set of AppImageConfigs, if there are any.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_image_configs = "AppImageConfigs",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListAppImageConfigsInput, options: CallOptions) !ListAppImageConfigsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListAppImageConfigsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListAppImageConfigs");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListAppImageConfigsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListAppImageConfigsOutput, body, allocator);
}
