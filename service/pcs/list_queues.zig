const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueueSummary = @import("queue_summary.zig").QueueSummary;

pub const ListQueuesInput = struct {
    /// The name or ID of the cluster to list queues for.
    cluster_identifier: []const u8,

    /// The maximum number of results that are returned per call. You can use
    /// `nextToken` to obtain further pages of results. The default is 10 results,
    /// and the maximum allowed page size is 100 results. A value of 0 uses the
    /// default.
    max_results: ?i32 = null,

    /// The value of `nextToken` is a unique pagination token for each page of
    /// results returned. If `nextToken` is returned, there are more results
    /// available. Make the call again using the returned token to retrieve the next
    /// page. Keep all other arguments unchanged. Each pagination token expires
    /// after 24 hours. Using an expired pagination token returns an `HTTP 400
    /// InvalidToken` error.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster_identifier = "clusterIdentifier",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListQueuesOutput = struct {
    /// The value of `nextToken` is a unique pagination token for each page of
    /// results returned. If `nextToken` is returned, there are more results
    /// available. Make the call again using the returned token to retrieve the next
    /// page. Keep all other arguments unchanged. Each pagination token expires
    /// after 24 hours. Using an expired pagination token returns an `HTTP 400
    /// InvalidToken` error.
    next_token: ?[]const u8 = null,

    /// The list of queues associated with the cluster.
    queues: ?[]const QueueSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .queues = "queues",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListQueuesInput, options: CallOptions) !ListQueuesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "pcs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListQueuesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pcs", "PCS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "AWSParallelComputingService.ListQueues");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListQueuesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListQueuesOutput, body, allocator);
}
