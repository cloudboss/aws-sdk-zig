const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContainerInstanceStatus = @import("container_instance_status.zig").ContainerInstanceStatus;
const ContainerInstance = @import("container_instance.zig").ContainerInstance;
const Failure = @import("failure.zig").Failure;

pub const UpdateContainerInstancesStateInput = struct {
    /// The short name or full Amazon Resource Name (ARN) of the cluster that hosts
    /// the container instance to update. If you do not specify a cluster, the
    /// default cluster is assumed.
    cluster: ?[]const u8 = null,

    /// A list of up to 10 container instance IDs or full ARN entries.
    container_instances: []const []const u8,

    /// The container instance state to update the container instance with. The only
    /// valid values for this action are `ACTIVE` and `DRAINING`. A container
    /// instance can only be updated to `DRAINING` status once it has reached an
    /// `ACTIVE` state. If a container instance is in `REGISTERING`,
    /// `DEREGISTERING`, or `REGISTRATION_FAILED` state you can describe the
    /// container instance but can't update the container instance state.
    status: ContainerInstanceStatus,

    pub const json_field_names = .{
        .cluster = "cluster",
        .container_instances = "containerInstances",
        .status = "status",
    };
};

pub const UpdateContainerInstancesStateOutput = struct {
    /// The list of container instances.
    container_instances: ?[]const ContainerInstance = null,

    /// Any failures associated with the call.
    failures: ?[]const Failure = null,

    pub const json_field_names = .{
        .container_instances = "containerInstances",
        .failures = "failures",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateContainerInstancesStateInput, options: CallOptions) !UpdateContainerInstancesStateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateContainerInstancesStateInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.UpdateContainerInstancesState");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateContainerInstancesStateOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateContainerInstancesStateOutput, body, allocator);
}
