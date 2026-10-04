const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DesiredStatus = @import("desired_status.zig").DesiredStatus;
const LaunchType = @import("launch_type.zig").LaunchType;

pub const ListTasksInput = struct {
    /// The short name or full Amazon Resource Name (ARN) of the cluster to use when
    /// filtering the `ListTasks` results. If you do not specify a cluster, the
    /// default cluster is assumed.
    cluster: ?[]const u8 = null,

    /// The container instance ID or full ARN of the container instance to use when
    /// filtering the `ListTasks` results. Specifying a `containerInstance` limits
    /// the results to tasks that belong to that container instance.
    container_instance: ?[]const u8 = null,

    /// The name of the daemon to use when filtering the `ListTasks` results.
    /// Specifying a `daemonName` limits the results to tasks that belong to that
    /// daemon.
    daemon_name: ?[]const u8 = null,

    /// The task desired status to use when filtering the `ListTasks` results.
    /// Specifying a `desiredStatus` of `STOPPED` limits the results to tasks that
    /// Amazon ECS has set the desired status to `STOPPED`. This can be useful for
    /// debugging tasks that aren't starting properly or have died or finished. The
    /// default status filter is `RUNNING`, which shows tasks that Amazon ECS has
    /// set the desired status to `RUNNING`.
    ///
    /// Although you can filter results based on a desired status of `PENDING`, this
    /// doesn't return any results. Amazon ECS never sets the desired status of a
    /// task to that value (only a task's `lastStatus` may have a value of
    /// `PENDING`).
    desired_status: ?DesiredStatus = null,

    /// The name of the task definition family to use when filtering the `ListTasks`
    /// results. Specifying a `family` limits the results to tasks that belong to
    /// that family.
    family: ?[]const u8 = null,

    /// The launch type to use when filtering the `ListTasks` results.
    launch_type: ?LaunchType = null,

    /// The maximum number of task results that `ListTasks` returned in paginated
    /// output. When this parameter is used, `ListTasks` only returns `maxResults`
    /// results in a single page along with a `nextToken` response element. The
    /// remaining results of the initial request can be seen by sending another
    /// `ListTasks` request with the returned `nextToken` value. This value can be
    /// between 1 and 100. If this parameter isn't used, then `ListTasks` returns up
    /// to 100 results and a `nextToken` value if applicable.
    max_results: ?i32 = null,

    /// The `nextToken` value returned from a `ListTasks` request indicating that
    /// more results are available to fulfill the request and further calls will be
    /// needed. If `maxResults` was provided, it's possible the number of results to
    /// be fewer than `maxResults`.
    ///
    /// This token should be treated as an opaque identifier that is only used to
    /// retrieve the next items in a list and not for other programmatic purposes.
    next_token: ?[]const u8 = null,

    /// The name of the service to use when filtering the `ListTasks` results.
    /// Specifying a `serviceName` limits the results to tasks that belong to that
    /// service.
    service_name: ?[]const u8 = null,

    /// The `startedBy` value to filter the task results with. Specifying a
    /// `startedBy` value limits the results to tasks that were started with that
    /// value.
    ///
    /// When you specify `startedBy` as the filter, it must be the only filter that
    /// you use.
    started_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .cluster = "cluster",
        .container_instance = "containerInstance",
        .daemon_name = "daemonName",
        .desired_status = "desiredStatus",
        .family = "family",
        .launch_type = "launchType",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .service_name = "serviceName",
        .started_by = "startedBy",
    };
};

pub const ListTasksOutput = struct {
    /// The `nextToken` value to include in a future `ListTasks` request. When the
    /// results of a `ListTasks` request exceed `maxResults`, this value can be used
    /// to retrieve the next page of results. This value is `null` when there are no
    /// more results to return.
    next_token: ?[]const u8 = null,

    /// The list of task ARN entries for the `ListTasks` request.
    task_arns: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .task_arns = "taskArns",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTasksInput, options: CallOptions) !ListTasksOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTasksInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.ListTasks");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTasksOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTasksOutput, body, allocator);
}
