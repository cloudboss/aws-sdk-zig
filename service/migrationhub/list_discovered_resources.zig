const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DiscoveredResource = @import("discovered_resource.zig").DiscoveredResource;

pub const ListDiscoveredResourcesInput = struct {
    /// The maximum number of results returned per page.
    max_results: ?i32 = null,

    /// The name of the MigrationTask. *Do not store personal data in this
    /// field.*
    migration_task_name: []const u8,

    /// If a `NextToken` was returned by a previous call, there are more results
    /// available. To retrieve the next page of results, make the call again using
    /// the returned
    /// token in `NextToken`.
    next_token: ?[]const u8 = null,

    /// The name of the ProgressUpdateStream.
    progress_update_stream: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .migration_task_name = "MigrationTaskName",
        .next_token = "NextToken",
        .progress_update_stream = "ProgressUpdateStream",
    };
};

pub const ListDiscoveredResourcesOutput = struct {
    /// Returned list of discovered resources associated with the given
    /// MigrationTask.
    discovered_resource_list: ?[]const DiscoveredResource = null,

    /// If there are more discovered resources than the max result, return the next
    /// token to be
    /// passed to the next call as a bookmark of where to start from.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .discovered_resource_list = "DiscoveredResourceList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDiscoveredResourcesInput, options: CallOptions) !ListDiscoveredResourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mgh", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDiscoveredResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mgh", "Migration Hub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSMigrationHub.ListDiscoveredResources");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDiscoveredResourcesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDiscoveredResourcesOutput, body, allocator);
}
