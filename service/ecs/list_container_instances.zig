const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContainerInstanceStatus = @import("container_instance_status.zig").ContainerInstanceStatus;

pub const ListContainerInstancesInput = struct {
    /// The short name or full Amazon Resource Name (ARN) of the cluster that hosts
    /// the container instances to list. If you do not specify a cluster, the
    /// default cluster is assumed.
    cluster: ?[]const u8 = null,

    /// You can filter the results of a `ListContainerInstances` operation with
    /// cluster query language statements. For more information, see [Cluster Query
    /// Language](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cluster-query-language.html) in the *Amazon Elastic Container Service Developer Guide*.
    filter: ?[]const u8 = null,

    /// The maximum number of container instance results that
    /// `ListContainerInstances` returned in paginated output. When this parameter
    /// is used, `ListContainerInstances` only returns `maxResults` results in a
    /// single page along with a `nextToken` response element. The remaining results
    /// of the initial request can be seen by sending another
    /// `ListContainerInstances` request with the returned `nextToken` value. This
    /// value can be between 1 and 100. If this parameter isn't used, then
    /// `ListContainerInstances` returns up to 100 results and a `nextToken` value
    /// if applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a `ListContainerInstances` request
    /// indicating that more results are available to fulfill the request and
    /// further calls are needed. If `maxResults` was provided, it's possible the
    /// number of results to be fewer than `maxResults`.
    ///
    /// This token should be treated as an opaque identifier that is only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    /// Filters the container instances by status. For example, if you specify the
    /// `DRAINING` status, the results include only container instances that have
    /// been set to `DRAINING` using
    /// [UpdateContainerInstancesState](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_UpdateContainerInstancesState.html). If you don't specify this parameter, the The default is to include container instances set to all states other than `INACTIVE`.
    status: ?ContainerInstanceStatus = null,

    pub const json_field_names = .{
        .cluster = "cluster",
        .filter = "filter",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .status = "status",
    };
};

pub const ListContainerInstancesOutput = struct {
    /// The list of container instances with full ARN entries for each container
    /// instance associated with the specified cluster.
    container_instance_arns: ?[]const []const u8 = null,

    /// The `nextToken` value to include in a future `ListContainerInstances`
    /// request. When the results of a `ListContainerInstances` request exceed
    /// `maxResults`, this value can be used to retrieve the next page of results.
    /// This value is `null` when there are no more results to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_instance_arns = "containerInstanceArns",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListContainerInstancesInput, options: CallOptions) !ListContainerInstancesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListContainerInstancesInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.ListContainerInstances");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListContainerInstancesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListContainerInstancesOutput, body, allocator);
}
