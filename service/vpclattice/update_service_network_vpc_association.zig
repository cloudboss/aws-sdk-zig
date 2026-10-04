const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DnsOptions = @import("dns_options.zig").DnsOptions;
const ServiceNetworkVpcAssociationStatus = @import("service_network_vpc_association_status.zig").ServiceNetworkVpcAssociationStatus;

pub const UpdateServiceNetworkVpcAssociationInput = struct {
    /// DNS options for the service network VPC association.
    dns_options: ?DnsOptions = null,

    /// Indicates if private DNS is enabled for the VPC association.
    private_dns_enabled: ?bool = null,

    /// The IDs of the security groups.
    security_group_ids: ?[]const []const u8 = null,

    /// The ID or ARN of the association.
    service_network_vpc_association_identifier: []const u8,

    pub const json_field_names = .{
        .dns_options = "dnsOptions",
        .private_dns_enabled = "privateDnsEnabled",
        .security_group_ids = "securityGroupIds",
        .service_network_vpc_association_identifier = "serviceNetworkVpcAssociationIdentifier",
    };
};

pub const UpdateServiceNetworkVpcAssociationOutput = struct {
    /// The Amazon Resource Name (ARN) of the association.
    arn: ?[]const u8 = null,

    /// The account that created the association.
    created_by: ?[]const u8 = null,

    /// DNS options for the service network VPC association.
    dns_options: ?DnsOptions = null,

    /// The ID of the association.
    id: ?[]const u8 = null,

    /// Indicates if private DNS is enabled for the VPC association.
    private_dns_enabled: ?bool = null,

    /// The IDs of the security groups.
    security_group_ids: ?[]const []const u8 = null,

    /// The status. You can retry the operation if the status is `DELETE_FAILED`.
    /// However, if you retry it while the status is `DELETE_IN_PROGRESS`, there is
    /// no change in the status.
    status: ?ServiceNetworkVpcAssociationStatus = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_by = "createdBy",
        .dns_options = "dnsOptions",
        .id = "id",
        .private_dns_enabled = "privateDnsEnabled",
        .security_group_ids = "securityGroupIds",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateServiceNetworkVpcAssociationInput, options: CallOptions) !UpdateServiceNetworkVpcAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateServiceNetworkVpcAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/servicenetworkvpcassociations/");
    try path_buf.appendSlice(allocator, input.service_network_vpc_association_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.dns_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dnsOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.private_dns_enabled) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"privateDnsEnabled\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateServiceNetworkVpcAssociationOutput {
    const result: UpdateServiceNetworkVpcAssociationOutput = try aws.json.parseJsonObject(
        UpdateServiceNetworkVpcAssociationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
