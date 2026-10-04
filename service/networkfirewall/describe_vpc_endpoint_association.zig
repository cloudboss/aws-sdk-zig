const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const VpcEndpointAssociation = @import("vpc_endpoint_association.zig").VpcEndpointAssociation;
const VpcEndpointAssociationStatus = @import("vpc_endpoint_association_status.zig").VpcEndpointAssociationStatus;

pub const DescribeVpcEndpointAssociationInput = struct {
    /// The Amazon Resource Name (ARN) of a VPC endpoint association.
    vpc_endpoint_association_arn: []const u8,

    pub const json_field_names = .{
        .vpc_endpoint_association_arn = "VpcEndpointAssociationArn",
    };
};

pub const DescribeVpcEndpointAssociationOutput = struct {
    /// The configuration settings for the VPC endpoint association. These settings
    /// include the firewall and the VPC and subnet to use for the firewall
    /// endpoint.
    vpc_endpoint_association: ?VpcEndpointAssociation = null,

    /// Detailed information about the current status of a VpcEndpointAssociation.
    /// You can retrieve this
    /// by calling DescribeVpcEndpointAssociation and providing the VPC endpoint
    /// association ARN.
    vpc_endpoint_association_status: ?VpcEndpointAssociationStatus = null,

    pub const json_field_names = .{
        .vpc_endpoint_association = "VpcEndpointAssociation",
        .vpc_endpoint_association_status = "VpcEndpointAssociationStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeVpcEndpointAssociationInput, options: CallOptions) !DescribeVpcEndpointAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeVpcEndpointAssociationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.DescribeVpcEndpointAssociation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeVpcEndpointAssociationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeVpcEndpointAssociationOutput, body, allocator);
}
