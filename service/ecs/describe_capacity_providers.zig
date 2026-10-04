const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapacityProviderField = @import("capacity_provider_field.zig").CapacityProviderField;
const CapacityProvider = @import("capacity_provider.zig").CapacityProvider;
const Failure = @import("failure.zig").Failure;

pub const DescribeCapacityProvidersInput = struct {
    /// The short name or full Amazon Resource Name (ARN) of one or more capacity
    /// providers. Up to `100` capacity providers can be described in an action.
    capacity_providers: ?[]const []const u8 = null,

    /// The name of the cluster to describe capacity providers for. When specified,
    /// only capacity providers associated with this cluster are returned, including
    /// Amazon ECS Managed Instances capacity providers.
    cluster: ?[]const u8 = null,

    /// Specifies whether or not you want to see the resource tags for the capacity
    /// provider. If `TAGS` is specified, the tags are included in the response. If
    /// this field is omitted, tags aren't included in the response.
    include: ?[]const CapacityProviderField = null,

    /// The maximum number of account setting results returned by
    /// `DescribeCapacityProviders` in paginated output. When this parameter is
    /// used, `DescribeCapacityProviders` only returns `maxResults` results in a
    /// single page along with a `nextToken` response element. The remaining results
    /// of the initial request can be seen by sending another
    /// `DescribeCapacityProviders` request with the returned `nextToken` value.
    /// This value can be between 1 and 10. If this parameter is not used, then
    /// `DescribeCapacityProviders` returns up to 10 results and a `nextToken` value
    /// if applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a previous paginated
    /// `DescribeCapacityProviders` request where `maxResults` was used and the
    /// results exceeded the value of that parameter. Pagination continues from the
    /// end of the previous results that returned the `nextToken` value.
    ///
    /// This token should be treated as an opaque identifier that is only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity_providers = "capacityProviders",
        .cluster = "cluster",
        .include = "include",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const DescribeCapacityProvidersOutput = struct {
    /// The list of capacity providers.
    capacity_providers: ?[]const CapacityProvider = null,

    /// Any failures associated with the call.
    failures: ?[]const Failure = null,

    /// The `nextToken` value to include in a future `DescribeCapacityProviders`
    /// request. When the results of a `DescribeCapacityProviders` request exceed
    /// `maxResults`, this value can be used to retrieve the next page of results.
    /// This value is `null` when there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .capacity_providers = "capacityProviders",
        .failures = "failures",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCapacityProvidersInput, options: CallOptions) !DescribeCapacityProvidersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCapacityProvidersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.DescribeCapacityProviders");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCapacityProvidersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeCapacityProvidersOutput, body, allocator);
}
