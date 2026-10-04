const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const ExportImageTask = @import("export_image_task.zig").ExportImageTask;

pub const ListExportImageTasksInput = struct {
    /// Optional filters to apply when listing export image tasks. Filters help you
    /// narrow down the results based on specific criteria.
    filters: ?[]const Filter = null,

    /// The maximum number of export image tasks to return in a single request. The
    /// valid range is 1-500, with a default of 50.
    max_results: ?i32 = null,

    /// The pagination token from a previous request. Use this to retrieve the next
    /// page of results when there are more tasks than the MaxResults limit.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListExportImageTasksOutput = struct {
    /// The list of export image tasks that match the specified criteria.
    export_image_tasks: ?[]const ExportImageTask = null,

    /// The pagination token to use for retrieving the next page of results. This
    /// field is only present when there are more results available.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .export_image_tasks = "ExportImageTasks",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListExportImageTasksInput, options: CallOptions) !ListExportImageTasksOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appstream", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListExportImageTasksInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appstream2", "AppStream", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PhotonAdminProxyService.ListExportImageTasks");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListExportImageTasksOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListExportImageTasksOutput, body, allocator);
}
