const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContainerInstance = @import("container_instance.zig").ContainerInstance;

pub const DeregisterContainerInstanceInput = struct {
    /// The short name or full Amazon Resource Name (ARN) of the cluster that hosts
    /// the container instance to deregister. If you do not specify a cluster, the
    /// default cluster is assumed.
    cluster: ?[]const u8 = null,

    /// The container instance ID or full ARN of the container instance to
    /// deregister. For more information about the ARN format, see [Amazon Resource
    /// Name
    /// (ARN)](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-account-settings.html#ecs-resource-ids) in the *Amazon ECS Developer Guide*.
    container_instance: []const u8,

    /// Forces the container instance to be deregistered. If you have tasks running
    /// on the container instance when you deregister it with the `force` option,
    /// these tasks remain running until you terminate the instance or the tasks
    /// stop through some other means, but they're orphaned (no longer monitored or
    /// accounted for by Amazon ECS). If an orphaned task on your container instance
    /// is part of an Amazon ECS service, then the service scheduler starts another
    /// copy of that task, on a different container instance if possible.
    ///
    /// Any containers in orphaned service tasks that are registered with a Classic
    /// Load Balancer or an Application Load Balancer target group are deregistered.
    /// They begin connection draining according to the settings on the load
    /// balancer or target group.
    force: ?bool = null,

    pub const json_field_names = .{
        .cluster = "cluster",
        .container_instance = "containerInstance",
        .force = "force",
    };
};

pub const DeregisterContainerInstanceOutput = struct {
    /// The container instance that was deregistered.
    container_instance: ?ContainerInstance = null,

    pub const json_field_names = .{
        .container_instance = "containerInstance",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeregisterContainerInstanceInput, options: CallOptions) !DeregisterContainerInstanceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeregisterContainerInstanceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.DeregisterContainerInstance");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeregisterContainerInstanceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DeregisterContainerInstanceOutput, body, allocator);
}
