const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContainerMonitoringConfiguration = @import("container_monitoring_configuration.zig").ContainerMonitoringConfiguration;
const Tag = @import("tag.zig").Tag;
const ContainerMonitoringType = @import("container_monitoring_type.zig").ContainerMonitoringType;
const ContainerAssociationStatus = @import("container_association_status.zig").ContainerAssociationStatus;

pub const CreateContainerAssociationInput = struct {
    /// The descriptive name of the container association. You can't change the name
    /// of a container association after you create it.
    container_association_name: []const u8,

    /// The monitoring configurations for the container association. Each
    /// configuration specifies an Amazon ECS or Amazon EKS cluster
    /// to monitor and optional attribute filters to narrow which containers are
    /// tracked.
    container_monitoring_configurations: []const ContainerMonitoringConfiguration,

    /// A description of the container association.
    description: ?[]const u8 = null,

    /// The key:value pairs to associate with the resource.
    tags: ?[]const Tag = null,

    /// The type of containers to monitor. You can't change the container type after
    /// creation. Valid values:
    ///
    /// * `ECS` - Amazon Elastic Container Service
    ///
    /// * `EKS` - Amazon Elastic Kubernetes Service
    type: ContainerMonitoringType,

    pub const json_field_names = .{
        .container_association_name = "ContainerAssociationName",
        .container_monitoring_configurations = "ContainerMonitoringConfigurations",
        .description = "Description",
        .tags = "Tags",
        .type = "Type",
    };
};

pub const CreateContainerAssociationOutput = struct {
    /// The Amazon Resource Name (ARN) of the container association.
    container_association_arn: ?[]const u8 = null,

    /// The descriptive name of the container association.
    container_association_name: ?[]const u8 = null,

    /// The monitoring configurations for the container association.
    container_monitoring_configurations: ?[]const ContainerMonitoringConfiguration = null,

    /// A description of the container association.
    description: ?[]const u8 = null,

    /// The current status of the container association. For a new container
    /// association, the status is `CREATING`.
    status: ?ContainerAssociationStatus = null,

    /// The key:value pairs to associate with the resource.
    tags: ?[]const Tag = null,

    /// The container type. Valid values:
    ///
    /// * `ECS` - Amazon Elastic Container Service
    ///
    /// * `EKS` - Amazon Elastic Kubernetes Service
    type: ?ContainerMonitoringType = null,

    /// A token used for optimistic locking. Network Firewall returns a token to
    /// your requests that access the container association.
    /// The token marks the state of the container association resource at the time
    /// of the request.
    ///
    /// To make changes to the container association, you provide the token in your
    /// request. Network Firewall uses the token to ensure
    /// that the container association hasn't changed since you last retrieved it.
    /// If it has changed, the operation fails with an
    /// `InvalidTokenException`. If this happens, retrieve the container association
    /// again to get a current copy of it
    /// with a current token. Reapply your changes as needed, then try the operation
    /// again using the new token.
    update_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .container_association_arn = "ContainerAssociationArn",
        .container_association_name = "ContainerAssociationName",
        .container_monitoring_configurations = "ContainerMonitoringConfigurations",
        .description = "Description",
        .status = "Status",
        .tags = "Tags",
        .type = "Type",
        .update_token = "UpdateToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateContainerAssociationInput, options: CallOptions) !CreateContainerAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "network-firewall", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateContainerAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("network-firewall", "Network Firewall", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.CreateContainerAssociation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateContainerAssociationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateContainerAssociationOutput, body, allocator);
}
