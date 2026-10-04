const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceUpdateStatus = @import("service_update_status.zig").ServiceUpdateStatus;
const ServiceUpdate = @import("service_update.zig").ServiceUpdate;

pub const DescribeServiceUpdatesInput = struct {
    /// The list of cluster names to identify service updates to apply.
    cluster_names: ?[]const []const u8 = null,

    /// The maximum number of records to include in the response. If more records
    /// exist than the specified MaxResults value, a token is included in the
    /// response so that the remaining results can be retrieved.
    max_results: ?i32 = null,

    /// An optional argument to pass in case the total number of records exceeds the
    /// value of MaxResults. If nextToken is returned, there are more results
    /// available. The value of nextToken is a unique pagination token for each
    /// page. Make the call again using the returned token to retrieve the next
    /// page. Keep all other arguments unchanged.
    next_token: ?[]const u8 = null,

    /// The unique ID of the service update to describe.
    service_update_name: ?[]const u8 = null,

    /// The status(es) of the service updates to filter on.
    status: ?[]const ServiceUpdateStatus = null,

    pub const json_field_names = .{
        .cluster_names = "ClusterNames",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .service_update_name = "ServiceUpdateName",
        .status = "Status",
    };
};

pub const DescribeServiceUpdatesOutput = struct {
    /// An optional argument to pass in case the total number of records exceeds the
    /// value of MaxResults. If nextToken is returned, there are more results
    /// available. The value of nextToken is a unique pagination token for each
    /// page. Make the call again using the returned token to retrieve the next
    /// page. Keep all other arguments unchanged.
    next_token: ?[]const u8 = null,

    /// A list of service updates
    service_updates: ?[]const ServiceUpdate = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .service_updates = "ServiceUpdates",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeServiceUpdatesInput, options: CallOptions) !DescribeServiceUpdatesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "memorydb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeServiceUpdatesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("memory-db", "MemoryDB", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonMemoryDB.DescribeServiceUpdates");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeServiceUpdatesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeServiceUpdatesOutput, body, allocator);
}
