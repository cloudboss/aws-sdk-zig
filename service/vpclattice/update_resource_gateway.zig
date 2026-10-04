const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const ResourceGatewayStatus = @import("resource_gateway_status.zig").ResourceGatewayStatus;

pub const UpdateResourceGatewayInput = struct {
    /// The ID or ARN of the resource gateway.
    resource_gateway_identifier: []const u8,

    /// The IDs of the security groups associated with the resource gateway.
    security_group_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .resource_gateway_identifier = "resourceGatewayIdentifier",
        .security_group_ids = "securityGroupIds",
    };
};

pub const UpdateResourceGatewayOutput = struct {
    /// The Amazon Resource Name (ARN) of the resource gateway.
    arn: ?[]const u8 = null,

    /// The ID of the resource gateway.
    id: ?[]const u8 = null,

    /// The type of IP address used by the resource gateway.
    ip_address_type: ?IpAddressType = null,

    /// The name of the resource gateway.
    name: ?[]const u8 = null,

    /// The IDs of the security groups associated with the resource gateway.
    security_group_ids: ?[]const []const u8 = null,

    /// The status of the resource gateway.
    status: ?ResourceGatewayStatus = null,

    /// The IDs of the VPC subnets for the resource gateway.
    subnet_ids: ?[]const []const u8 = null,

    /// The ID of the VPC for the resource gateway.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .id = "id",
        .ip_address_type = "ipAddressType",
        .name = "name",
        .security_group_ids = "securityGroupIds",
        .status = "status",
        .subnet_ids = "subnetIds",
        .vpc_id = "vpcId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateResourceGatewayInput, options: CallOptions) !UpdateResourceGatewayOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateResourceGatewayInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/resourcegateways/");
    try path_buf.appendSlice(allocator, input.resource_gateway_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.security_group_ids) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"securityGroupIds\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateResourceGatewayOutput {
    var result: UpdateResourceGatewayOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateResourceGatewayOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
