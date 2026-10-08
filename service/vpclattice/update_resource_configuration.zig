const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceConfigurationDefinition = @import("resource_configuration_definition.zig").ResourceConfigurationDefinition;
const ProtocolType = @import("protocol_type.zig").ProtocolType;
const ResourceConfigurationStatus = @import("resource_configuration_status.zig").ResourceConfigurationStatus;
const ResourceConfigurationType = @import("resource_configuration_type.zig").ResourceConfigurationType;

pub const UpdateResourceConfigurationInput = struct {
    /// Indicates whether to add the resource configuration to service networks that
    /// are shared with other accounts.
    allow_association_to_shareable_service_network: ?bool = null,

    /// The TCP port ranges that a consumer can use to access a resource
    /// configuration. You can separate port ranges with a comma. Example: 1-65535
    /// or 1,2,22-30
    port_ranges: ?[]const []const u8 = null,

    /// Identifies the resource configuration in one of the following ways:
    ///
    /// * **Amazon Resource Name (ARN)** - Supported resource-types that are
    ///   provisioned by Amazon Web Services services, such as RDS databases, can be
    ///   identified by their ARN.
    /// * **Domain name** - Any domain name that is publicly resolvable.
    /// * **IP address** - For IPv4 and IPv6, only IP addresses in the VPC are
    ///   supported.
    resource_configuration_definition: ?ResourceConfigurationDefinition = null,

    /// The ID of the resource configuration.
    resource_configuration_identifier: []const u8,

    pub const json_field_names = .{
        .allow_association_to_shareable_service_network = "allowAssociationToShareableServiceNetwork",
        .port_ranges = "portRanges",
        .resource_configuration_definition = "resourceConfigurationDefinition",
        .resource_configuration_identifier = "resourceConfigurationIdentifier",
    };
};

pub const UpdateResourceConfigurationOutput = struct {
    /// Indicates whether to add the resource configuration to service networks that
    /// are shared with other accounts.
    allow_association_to_shareable_service_network: ?bool = null,

    /// The Amazon Resource Name (ARN) of the resource configuration.
    arn: ?[]const u8 = null,

    /// The ID of the resource configuration.
    id: ?[]const u8 = null,

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

    /// The ID of the resource gateway associated with the resource configuration.
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
    type: ?ResourceConfigurationType = null,

    pub const json_field_names = .{
        .allow_association_to_shareable_service_network = "allowAssociationToShareableServiceNetwork",
        .arn = "arn",
        .id = "id",
        .name = "name",
        .port_ranges = "portRanges",
        .protocol = "protocol",
        .resource_configuration_definition = "resourceConfigurationDefinition",
        .resource_configuration_group_id = "resourceConfigurationGroupId",
        .resource_gateway_id = "resourceGatewayId",
        .status = "status",
        .type = "type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateResourceConfigurationInput, options: CallOptions) !UpdateResourceConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateResourceConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/resourceconfigurations/");
    try path_buf.appendSlice(allocator, input.resource_configuration_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.allow_association_to_shareable_service_network) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"allowAssociationToShareableServiceNetwork\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.port_ranges) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"portRanges\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.resource_configuration_definition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"resourceConfigurationDefinition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateResourceConfigurationOutput {
    const result: UpdateResourceConfigurationOutput = try aws.json.parseJsonObject(
        UpdateResourceConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
