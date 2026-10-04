const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LaunchType = @import("launch_type.zig").LaunchType;
const ResourceManagementType = @import("resource_management_type.zig").ResourceManagementType;
const SchedulingStrategy = @import("scheduling_strategy.zig").SchedulingStrategy;

pub const ListServicesInput = struct {
    /// The short name or full Amazon Resource Name (ARN) of the cluster to use when
    /// filtering the `ListServices` results. If you do not specify a cluster, the
    /// default cluster is assumed.
    cluster: ?[]const u8 = null,

    /// The launch type to use when filtering the `ListServices` results.
    launch_type: ?LaunchType = null,

    /// The maximum number of service results that `ListServices` returned in
    /// paginated output. When this parameter is used, `ListServices` only returns
    /// `maxResults` results in a single page along with a `nextToken` response
    /// element. The remaining results of the initial request can be seen by sending
    /// another `ListServices` request with the returned `nextToken` value. This
    /// value can be between 1 and 100. If this parameter isn't used, then
    /// `ListServices` returns up to 10 results and a `nextToken` value if
    /// applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a `ListServices` request indicating that
    /// more results are available to fulfill the request and further calls will be
    /// needed. If `maxResults` was provided, it is possible the number of results
    /// to be fewer than `maxResults`.
    ///
    /// This token should be treated as an opaque identifier that is only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    /// The resourceManagementType type to use when filtering the `ListServices`
    /// results.
    resource_management_type: ?ResourceManagementType = null,

    /// The scheduling strategy to use when filtering the `ListServices` results.
    scheduling_strategy: ?SchedulingStrategy = null,

    pub const json_field_names = .{
        .cluster = "cluster",
        .launch_type = "launchType",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .resource_management_type = "resourceManagementType",
        .scheduling_strategy = "schedulingStrategy",
    };
};

pub const ListServicesOutput = struct {
    /// The `nextToken` value to include in a future `ListServices` request. When
    /// the results of a `ListServices` request exceed `maxResults`, this value can
    /// be used to retrieve the next page of results. This value is `null` when
    /// there are no more results to return.
    next_token: ?[]const u8 = null,

    /// The list of full ARN entries for each service that's associated with the
    /// specified cluster.
    service_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .service_arns = "serviceArns",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServicesInput, options: CallOptions) !ListServicesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListServicesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.ListServices");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListServicesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListServicesOutput, body, allocator);
}
