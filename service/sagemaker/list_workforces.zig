const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListWorkforcesSortByOptions = @import("list_workforces_sort_by_options.zig").ListWorkforcesSortByOptions;
const SortOrder = @import("sort_order.zig").SortOrder;
const Workforce = @import("workforce.zig").Workforce;

pub const ListWorkforcesInput = struct {
    /// The maximum number of workforces returned in the response.
    max_results: ?i32 = null,

    /// A filter you can use to search for workforces using part of the workforce
    /// name.
    name_contains: ?[]const u8 = null,

    /// A token to resume pagination.
    next_token: ?[]const u8 = null,

    /// Sort workforces using the workforce name or creation date.
    sort_by: ?ListWorkforcesSortByOptions = null,

    /// Sort workforces in ascending or descending order.
    sort_order: ?SortOrder = null,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .name_contains = "NameContains",
        .next_token = "NextToken",
        .sort_by = "SortBy",
        .sort_order = "SortOrder",
    };
};

pub const ListWorkforcesOutput = struct {
    /// A token to resume pagination.
    next_token: ?[]const u8 = null,

    /// A list containing information about your workforce.
    workforces: ?[]const Workforce = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .workforces = "Workforces",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListWorkforcesInput, options: CallOptions) !ListWorkforcesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListWorkforcesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.ListWorkforces");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListWorkforcesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListWorkforcesOutput, body, allocator);
}
