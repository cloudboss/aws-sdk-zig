const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoScalingGroupProviderUpdate = @import("auto_scaling_group_provider_update.zig").AutoScalingGroupProviderUpdate;
const UpdateManagedInstancesProviderConfiguration = @import("update_managed_instances_provider_configuration.zig").UpdateManagedInstancesProviderConfiguration;
const CapacityProvider = @import("capacity_provider.zig").CapacityProvider;

pub const UpdateCapacityProviderInput = struct {
    /// An object that represent the parameters to update for the Auto Scaling group
    /// capacity provider.
    auto_scaling_group_provider: ?AutoScalingGroupProviderUpdate = null,

    /// The name of the cluster that contains the capacity provider to update.
    /// Managed instances capacity providers are cluster-scoped and can only be
    /// updated within their associated cluster.
    cluster: ?[]const u8 = null,

    /// The updated configuration for the Amazon ECS Managed Instances provider. You
    /// can modify the infrastructure role, instance launch template, and tag
    /// propagation settings. Changes take effect for new instances launched after
    /// the update.
    managed_instances_provider: ?UpdateManagedInstancesProviderConfiguration = null,

    /// The name of the capacity provider to update.
    name: []const u8,

    pub const json_field_names = .{
        .auto_scaling_group_provider = "autoScalingGroupProvider",
        .cluster = "cluster",
        .managed_instances_provider = "managedInstancesProvider",
        .name = "name",
    };
};

pub const UpdateCapacityProviderOutput = struct {
    /// Details about the capacity provider.
    capacity_provider: ?CapacityProvider = null,

    pub const json_field_names = .{
        .capacity_provider = "capacityProvider",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCapacityProviderInput, options: CallOptions) !UpdateCapacityProviderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCapacityProviderInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.UpdateCapacityProvider");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCapacityProviderOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateCapacityProviderOutput, body, allocator);
}
