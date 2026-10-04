const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceGatewayIpAddressType = @import("resource_gateway_ip_address_type.zig").ResourceGatewayIpAddressType;
const ResourceConfigDnsResolution = @import("resource_config_dns_resolution.zig").ResourceConfigDnsResolution;
const ResourceGatewayStatus = @import("resource_gateway_status.zig").ResourceGatewayStatus;

pub const GetResourceGatewayInput = struct {
    /// The ID of the resource gateway.
    resource_gateway_identifier: []const u8,

    pub const json_field_names = .{
        .resource_gateway_identifier = "resourceGatewayIdentifier",
    };
};

pub const GetResourceGatewayOutput = struct {
    /// The Amazon Resource Name (ARN) of the resource gateway.
    arn: ?[]const u8 = null,

    /// The date and time that the resource gateway was created, in ISO-8601 format.
    created_at: ?i64 = null,

    /// The ID of the resource gateway.
    id: ?[]const u8 = null,

    /// The type of IP address for the resource gateway.
    ip_address_type: ?ResourceGatewayIpAddressType = null,

    /// The number of IPv4 addresses in each ENI for the resource gateway.
    ipv_4_addresses_per_eni: ?i32 = null,

    /// The date and time that the resource gateway was last updated, in ISO-8601
    /// format.
    last_updated_at: ?i64 = null,

    /// The AWS service that manages the resource gateway.
    managed_by: ?[]const u8 = null,

    /// The name of the resource gateway.
    name: ?[]const u8 = null,

    /// The DNS resolution type for resource configurations that are associated with
    /// this resource gateway.
    resource_config_dns_resolution: ?ResourceConfigDnsResolution = null,

    /// The security group IDs associated with the resource gateway.
    security_group_ids: ?[]const []const u8 = null,

    /// Indicates whether the resource gateway is managed by an AWS service.
    service_managed: ?bool = null,

    /// The status for the resource gateway.
    status: ?ResourceGatewayStatus = null,

    /// The IDs of the VPC subnets for resource gateway.
    subnet_ids: ?[]const []const u8 = null,

    /// The ID of the VPC for the resource gateway.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .id = "id",
        .ip_address_type = "ipAddressType",
        .ipv_4_addresses_per_eni = "ipv4AddressesPerEni",
        .last_updated_at = "lastUpdatedAt",
        .managed_by = "managedBy",
        .name = "name",
        .resource_config_dns_resolution = "resourceConfigDnsResolution",
        .security_group_ids = "securityGroupIds",
        .service_managed = "serviceManaged",
        .status = "status",
        .subnet_ids = "subnetIds",
        .vpc_id = "vpcId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceGatewayInput, options: CallOptions) !GetResourceGatewayOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/resourcegateways/");
    try path_buf.appendSlice(allocator, input.resource_gateway_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceGatewayOutput {
    var result: GetResourceGatewayOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetResourceGatewayOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
