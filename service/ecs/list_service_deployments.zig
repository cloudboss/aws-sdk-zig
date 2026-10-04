const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreatedAt = @import("created_at.zig").CreatedAt;
const ServiceDeploymentStatus = @import("service_deployment_status.zig").ServiceDeploymentStatus;
const ServiceDeploymentBrief = @import("service_deployment_brief.zig").ServiceDeploymentBrief;

pub const ListServiceDeploymentsInput = struct {
    /// The cluster that hosts the service. This can either be the cluster name or
    /// ARN. Starting April 15, 2023, Amazon Web Services will not onboard new
    /// customers to Amazon Elastic Inference (EI), and will help current customers
    /// migrate their workloads to options that offer better price and performance.
    /// If you don't specify a cluster, `default` is used.
    cluster: ?[]const u8 = null,

    /// An optional filter you can use to narrow the results by the service creation
    /// date. If you do not specify a value, the result includes all services
    /// created before the current time. The format is yyyy-MM-dd HH:mm:ss.SSSSSS.
    created_at: ?CreatedAt = null,

    /// The maximum number of service deployment results that
    /// `ListServiceDeployments` returned in paginated output. When this parameter
    /// is used, `ListServiceDeployments` only returns `maxResults` results in a
    /// single page along with a `nextToken` response element. The remaining results
    /// of the initial request can be seen by sending another
    /// `ListServiceDeployments` request with the returned `nextToken` value. This
    /// value can be between 1 and 100. If this parameter isn't used, then
    /// `ListServiceDeployments` returns up to 20 results and a `nextToken` value if
    /// applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a `ListServiceDeployments` request
    /// indicating that more results are available to fulfill the request and
    /// further calls are needed. If you provided `maxResults`, it's possible the
    /// number of results is fewer than `maxResults`.
    next_token: ?[]const u8 = null,

    /// The ARN or name of the service
    service: []const u8,

    /// An optional filter you can use to narrow the results. If you do not specify
    /// a status, then all status values are included in the result.
    status: ?[]const ServiceDeploymentStatus = null,

    pub const json_field_names = .{
        .cluster = "cluster",
        .created_at = "createdAt",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .service = "service",
        .status = "status",
    };
};

pub const ListServiceDeploymentsOutput = struct {
    /// The `nextToken` value to include in a future `ListServiceDeployments`
    /// request. When the results of a `ListServiceDeployments` request exceed
    /// `maxResults`, this value can be used to retrieve the next page of results.
    /// This value is null when there are no more results to return.
    next_token: ?[]const u8 = null,

    /// An overview of the service deployment, including the following properties:
    ///
    /// * The ARN of the service deployment.
    /// * The ARN of the service being deployed.
    /// * The ARN of the cluster that hosts the service in the service deployment.
    /// * The time that the service deployment started.
    /// * The time that the service deployment completed.
    /// * The service deployment status.
    /// * Information about why the service deployment is in the current state.
    /// * The ARN of the service revision that is being deployed.
    service_deployments: ?[]const ServiceDeploymentBrief = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .service_deployments = "serviceDeployments",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListServiceDeploymentsInput, options: CallOptions) !ListServiceDeploymentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListServiceDeploymentsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.ListServiceDeployments");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListServiceDeploymentsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListServiceDeploymentsOutput, body, allocator);
}
