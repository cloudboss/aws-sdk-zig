const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DnsOptions = @import("dns_options.zig").DnsOptions;
const ServiceNetworkVpcAssociationStatus = @import("service_network_vpc_association_status.zig").ServiceNetworkVpcAssociationStatus;

pub const GetServiceNetworkVpcAssociationInput = struct {
    /// The ID or ARN of the association.
    service_network_vpc_association_identifier: []const u8,

    pub const json_field_names = .{
        .service_network_vpc_association_identifier = "serviceNetworkVpcAssociationIdentifier",
    };
};

pub const GetServiceNetworkVpcAssociationOutput = struct {
    /// The Amazon Resource Name (ARN) of the association.
    arn: ?[]const u8 = null,

    /// The date and time that the association was created, in ISO-8601 format.
    created_at: ?i64 = null,

    /// The account that created the association.
    created_by: ?[]const u8 = null,

    /// DNS options for the service network VPC association.
    dns_options: ?DnsOptions = null,

    /// The failure code.
    failure_code: ?[]const u8 = null,

    /// The failure message.
    failure_message: ?[]const u8 = null,

    /// The ID of the association.
    id: ?[]const u8 = null,

    /// The date and time that the association was last updated, in ISO-8601 format.
    last_updated_at: ?i64 = null,

    /// Indicates if private DNS is enabled in the VPC association.
    private_dns_enabled: ?bool = null,

    /// The IDs of the security groups.
    security_group_ids: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the service network.
    service_network_arn: ?[]const u8 = null,

    /// The ID of the service network.
    service_network_id: ?[]const u8 = null,

    /// The name of the service network.
    service_network_name: ?[]const u8 = null,

    /// The status of the association.
    status: ?ServiceNetworkVpcAssociationStatus = null,

    /// The ID of the VPC.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .dns_options = "dnsOptions",
        .failure_code = "failureCode",
        .failure_message = "failureMessage",
        .id = "id",
        .last_updated_at = "lastUpdatedAt",
        .private_dns_enabled = "privateDnsEnabled",
        .security_group_ids = "securityGroupIds",
        .service_network_arn = "serviceNetworkArn",
        .service_network_id = "serviceNetworkId",
        .service_network_name = "serviceNetworkName",
        .status = "status",
        .vpc_id = "vpcId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetServiceNetworkVpcAssociationInput, options: CallOptions) !GetServiceNetworkVpcAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetServiceNetworkVpcAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/servicenetworkvpcassociations/");
    try path_buf.appendSlice(allocator, input.service_network_vpc_association_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetServiceNetworkVpcAssociationOutput {
    var result: GetServiceNetworkVpcAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetServiceNetworkVpcAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
