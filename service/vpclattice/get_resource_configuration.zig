const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VerificationStatus = @import("verification_status.zig").VerificationStatus;
const ProtocolType = @import("protocol_type.zig").ProtocolType;
const ResourceConfigurationDefinition = @import("resource_configuration_definition.zig").ResourceConfigurationDefinition;
const ResourceConfigurationStatus = @import("resource_configuration_status.zig").ResourceConfigurationStatus;
const ResourceConfigurationType = @import("resource_configuration_type.zig").ResourceConfigurationType;

pub const GetResourceConfigurationInput = struct {
    /// The ID of the resource configuration.
    resource_configuration_identifier: []const u8,

    pub const json_field_names = .{
        .resource_configuration_identifier = "resourceConfigurationIdentifier",
    };
};

pub const GetResourceConfigurationOutput = struct {
    /// Specifies whether the resource configuration is associated with a sharable
    /// service network.
    allow_association_to_shareable_service_network: ?bool = null,

    /// Indicates whether the resource configuration was created and is managed by
    /// Amazon.
    amazon_managed: ?bool = null,

    /// The Amazon Resource Name (ARN) of the resource configuration.
    arn: ?[]const u8 = null,

    /// The date and time that the resource configuration was created, in ISO-8601
    /// format.
    created_at: ?i64 = null,

    /// The custom domain name of the resource configuration.
    custom_domain_name: ?[]const u8 = null,

    /// The ARN of the domain verification.
    domain_verification_arn: ?[]const u8 = null,

    /// The domain verification ID.
    domain_verification_id: ?[]const u8 = null,

    /// The domain verification status.
    domain_verification_status: ?VerificationStatus = null,

    /// The reason the create-resource-configuration request failed.
    failure_reason: ?[]const u8 = null,

    /// (GROUP) The group domain for a group resource configuration. Any domains
    /// that you create for the child resource are subdomains of the group domain.
    /// Child resources inherit the verification status of the domain.
    group_domain: ?[]const u8 = null,

    /// The ID of the resource configuration.
    id: ?[]const u8 = null,

    /// The most recent date and time that the resource configuration was updated,
    /// in ISO-8601 format.
    last_updated_at: ?i64 = null,

    /// The name of the resource configuration.
    name: ?[]const u8 = null,

    /// The TCP port ranges that a consumer can use to access a resource
    /// configuration. You can separate port ranges with a comma. Example: 1-65535
    /// or 1,2,22-30
    port_ranges: ?[]const []const u8 = null,

    /// The TCP protocol accepted by the specified resource configuration.
    protocol: ?ProtocolType = null,

    /// The resource configuration.
    resource_configuration_definition: ?ResourceConfigurationDefinition = null,

    /// The ID of the group resource configuration.
    resource_configuration_group_id: ?[]const u8 = null,

    /// The ID of the resource gateway used to connect to the resource configuration
    /// in a given VPC. You can specify the resource gateway identifier only for
    /// resource configurations with type SINGLE, GROUP, ARN, or CIDR.
    resource_gateway_id: ?[]const u8 = null,

    /// The status of the resource configuration.
    status: ?ResourceConfigurationStatus = null,

    /// The type of resource configuration.
    ///
    /// * `SINGLE` - A single resource.
    /// * `GROUP` - A group of resources.
    /// * `CHILD` - A single resource that is part of a group resource
    ///   configuration.
    /// * `ARN` - An Amazon Web Services resource.
    /// * `CIDR` - A network segment (a range of IP addresses) accessed through a
    ///   `Tunnel` VPC endpoint.
    @"type": ?ResourceConfigurationType = null,

    pub const json_field_names = .{
        .allow_association_to_shareable_service_network = "allowAssociationToShareableServiceNetwork",
        .amazon_managed = "amazonManaged",
        .arn = "arn",
        .created_at = "createdAt",
        .custom_domain_name = "customDomainName",
        .domain_verification_arn = "domainVerificationArn",
        .domain_verification_id = "domainVerificationId",
        .domain_verification_status = "domainVerificationStatus",
        .failure_reason = "failureReason",
        .group_domain = "groupDomain",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .name = "name",
        .port_ranges = "portRanges",
        .protocol = "protocol",
        .resource_configuration_definition = "resourceConfigurationDefinition",
        .resource_configuration_group_id = "resourceConfigurationGroupId",
        .resource_gateway_id = "resourceGatewayId",
        .status = "status",
        .@"type" = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceConfigurationInput, options: CallOptions) !GetResourceConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "vpc-lattice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/resourceconfigurations/");
    try path_buf.appendSlice(allocator, input.resource_configuration_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceConfigurationOutput {
    const result: GetResourceConfigurationOutput = try aws.json.parseJsonObject(
        GetResourceConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
