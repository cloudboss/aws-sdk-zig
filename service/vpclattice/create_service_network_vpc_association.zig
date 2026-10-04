const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DnsOptions = @import("dns_options.zig").DnsOptions;
const ServiceNetworkVpcAssociationStatus = @import("service_network_vpc_association_status.zig").ServiceNetworkVpcAssociationStatus;

pub const CreateServiceNetworkVpcAssociationInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you retry a request that completed
    /// successfully using the same client token and parameters, the retry succeeds
    /// without performing any actions. If the parameters aren't identical, the
    /// retry fails.
    client_token: ?[]const u8 = null,

    /// DNS options for the service network VPC association.
    dns_options: ?DnsOptions = null,

    /// Indicates if private DNS is enabled for the VPC association.
    private_dns_enabled: ?bool = null,

    /// The IDs of the security groups. Security groups aren't added by default. You
    /// can add a security group to apply network level controls to control which
    /// resources in a VPC are allowed to access the service network and its
    /// services. For more information, see [Control traffic to resources using
    /// security
    /// groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html) in the *Amazon VPC User Guide*.
    security_group_ids: ?[]const []const u8 = null,

    /// The ID or ARN of the service network. You must use an ARN if the resources
    /// are in different accounts.
    service_network_identifier: []const u8,

    /// The tags for the association.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The ID of the VPC.
    vpc_identifier: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .dns_options = "dnsOptions",
        .private_dns_enabled = "privateDnsEnabled",
        .security_group_ids = "securityGroupIds",
        .service_network_identifier = "serviceNetworkIdentifier",
        .tags = "tags",
        .vpc_identifier = "vpcIdentifier",
    };
};

pub const CreateServiceNetworkVpcAssociationOutput = struct {
    /// The Amazon Resource Name (ARN) of the association.
    arn: ?[]const u8 = null,

    /// The account that created the association.
    created_by: ?[]const u8 = null,

    dns_options: ?DnsOptions = null,

    /// The ID of the association.
    id: ?[]const u8 = null,

    /// Indicates if private DNS is enabled for the VPC association.
    private_dns_enabled: ?bool = null,

    /// The IDs of the security groups.
    security_group_ids: ?[]const []const u8 = null,

    /// The association status.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServiceNetworkVpcAssociationInput, options: CallOptions) !CreateServiceNetworkVpcAssociationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateServiceNetworkVpcAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpc-lattice", "VPC Lattice", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/servicenetworkvpcassociations";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"serviceNetworkIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.service_network_identifier), input.service_network_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"vpcIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.vpc_identifier), input.vpc_identifier, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateServiceNetworkVpcAssociationOutput {
    const result: CreateServiceNetworkVpcAssociationOutput = try aws.json.parseJsonObject(
        CreateServiceNetworkVpcAssociationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
