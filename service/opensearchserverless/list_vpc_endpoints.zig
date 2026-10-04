const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VpcEndpointFilters = @import("vpc_endpoint_filters.zig").VpcEndpointFilters;
const VpcEndpointSummary = @import("vpc_endpoint_summary.zig").VpcEndpointSummary;

pub const ListVpcEndpointsInput = struct {
    /// An optional parameter that specifies the maximum number of results to
    /// return. You can use `nextToken` to get the next page of results. The default
    /// is 20.
    max_results: ?i32 = null,

    /// If your initial `ListVpcEndpoints` operation returns a `nextToken`, you can
    /// include the returned `nextToken` in subsequent `ListVpcEndpoints`
    /// operations, which returns results in the next page.
    next_token: ?[]const u8 = null,

    /// Filter the results according to the current status of the VPC endpoint.
    /// Possible statuses are `CREATING`, `DELETING`, `UPDATING`, `ACTIVE`, and
    /// `FAILED`.
    vpc_endpoint_filters: ?VpcEndpointFilters = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .next_token = "nextToken",
        .vpc_endpoint_filters = "vpcEndpointFilters",
    };
};

pub const ListVpcEndpointsOutput = struct {
    /// When `nextToken` is returned, there are more results available. The value of
    /// `nextToken` is a unique pagination token for each page. Make the call again
    /// using the returned token to retrieve the next page.
    next_token: ?[]const u8 = null,

    /// Details about each VPC endpoint, including the name and current status.
    vpc_endpoint_summaries: ?[]const VpcEndpointSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .vpc_endpoint_summaries = "vpcEndpointSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListVpcEndpointsInput, options: CallOptions) !ListVpcEndpointsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aoss", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListVpcEndpointsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aoss", "OpenSearchServerless", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "OpenSearchServerless.ListVpcEndpoints");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListVpcEndpointsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListVpcEndpointsOutput, body, allocator);
}
