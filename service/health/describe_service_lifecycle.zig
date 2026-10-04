const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceLifecycleFilter = @import("service_lifecycle_filter.zig").ServiceLifecycleFilter;
const ServiceLifecycle = @import("service_lifecycle.zig").ServiceLifecycle;

pub const DescribeServiceLifecycleInput = struct {
    /// Values to narrow the results returned.
    filter: ?ServiceLifecycleFilter = null,

    /// The maximum number of items to return in one batch, between 1 and 20,
    /// inclusive.
    max_results: ?i32 = null,

    /// If the results of a search are large, only a portion of the
    /// results are returned, and a `nextToken` pagination token is returned in the
    /// response. To
    /// retrieve the next batch of results, reissue the search request and include
    /// the returned token.
    /// When all results have been returned, the response does not contain a
    /// pagination token value.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "filter",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const DescribeServiceLifecycleOutput = struct {
    /// If the results of a search are large, only a portion of the
    /// results are returned, and a `nextToken` pagination token is returned in the
    /// response. To
    /// retrieve the next batch of results, reissue the search request and include
    /// the returned token.
    /// When all results have been returned, the response does not contain a
    /// pagination token value.
    next_token: ?[]const u8 = null,

    /// The list of service lifecycle entries matching the filter criteria.
    service_lifecycles: ?[]const ServiceLifecycle = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .service_lifecycles = "serviceLifecycles",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeServiceLifecycleInput, options: CallOptions) !DescribeServiceLifecycleOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "health", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeServiceLifecycleInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("health", "Health", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSHealth_20160804.DescribeServiceLifecycle");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeServiceLifecycleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeServiceLifecycleOutput, body, allocator);
}
