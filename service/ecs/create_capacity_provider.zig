const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoScalingGroupProvider = @import("auto_scaling_group_provider.zig").AutoScalingGroupProvider;
const CreateManagedInstancesProviderConfiguration = @import("create_managed_instances_provider_configuration.zig").CreateManagedInstancesProviderConfiguration;
const Tag = @import("tag.zig").Tag;
const CapacityProvider = @import("capacity_provider.zig").CapacityProvider;

pub const CreateCapacityProviderInput = struct {
    /// The details of the Auto Scaling group for the capacity provider.
    auto_scaling_group_provider: ?AutoScalingGroupProvider = null,

    /// The name of the cluster to associate with the capacity provider. When you
    /// create a capacity provider with Amazon ECS Managed Instances, it becomes
    /// available only within the specified cluster.
    cluster: ?[]const u8 = null,

    /// The configuration for the Amazon ECS Managed Instances provider. This
    /// configuration specifies how Amazon ECS manages Amazon EC2 instances on your
    /// behalf, including the infrastructure role, instance launch template, and tag
    /// propagation settings.
    managed_instances_provider: ?CreateManagedInstancesProviderConfiguration = null,

    /// The name of the capacity provider. Up to 255 characters are allowed. They
    /// include letters (both upper and lowercase letters), numbers, underscores
    /// (_), and hyphens (-). The name can't be prefixed with "`aws`", "`ecs`", or
    /// "`fargate`".
    name: []const u8,

    /// The metadata that you apply to the capacity provider to categorize and
    /// organize them more conveniently. Each tag consists of a key and an optional
    /// value. You define both of them.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only one value.
    /// * Maximum key length - 128 Unicode characters in UTF-8
    /// * Maximum value length - 256 Unicode characters in UTF-8
    /// * If your tagging schema is used across multiple services and resources,
    ///   remember that other services may have restrictions on allowed characters.
    ///   Generally allowed characters are: letters, numbers, and spaces
    ///   representable in UTF-8, and the following characters: + - = . _ : / @.
    /// * Tag keys and values are case-sensitive.
    /// * Do not use `aws:`, `AWS:`, or any upper or lowercase combination of such
    ///   as a prefix for either keys or values as it is reserved for Amazon Web
    ///   Services use. You cannot edit or delete tag keys or values with this
    ///   prefix. Tags with this prefix do not count against your tags per resource
    ///   limit.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .auto_scaling_group_provider = "autoScalingGroupProvider",
        .cluster = "cluster",
        .managed_instances_provider = "managedInstancesProvider",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateCapacityProviderOutput = struct {
    /// The full description of the new capacity provider.
    capacity_provider: ?CapacityProvider = null,

    pub const json_field_names = .{
        .capacity_provider = "capacityProvider",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCapacityProviderInput, options: CallOptions) !CreateCapacityProviderOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCapacityProviderInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.CreateCapacityProvider");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCapacityProviderOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateCapacityProviderOutput, body, allocator);
}
