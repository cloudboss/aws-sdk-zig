const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SubnetMapping = @import("subnet_mapping.zig").SubnetMapping;
const Tag = @import("tag.zig").Tag;
const VpcEndpointAssociation = @import("vpc_endpoint_association.zig").VpcEndpointAssociation;
const VpcEndpointAssociationStatus = @import("vpc_endpoint_association_status.zig").VpcEndpointAssociationStatus;

pub const CreateVpcEndpointAssociationInput = struct {
    /// A description of the VPC endpoint association.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the firewall.
    firewall_arn: []const u8,

    subnet_mapping: SubnetMapping,

    /// The key:value pairs to associate with the resource.
    tags: ?[]const Tag = null,

    /// The unique identifier of the VPC where you want to create a firewall
    /// endpoint.
    vpc_id: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .firewall_arn = "FirewallArn",
        .subnet_mapping = "SubnetMapping",
        .tags = "Tags",
        .vpc_id = "VpcId",
    };
};

pub const CreateVpcEndpointAssociationOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateVpcEndpointAssociationInput, options: CallOptions) !CreateVpcEndpointAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateVpcEndpointAssociationInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "NetworkFirewall_20201112.CreateVpcEndpointAssociation");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateVpcEndpointAssociationOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateVpcEndpointAssociationOutput, body, allocator);
}
