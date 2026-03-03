const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateServiceNetworkVpcAssociationInput, options: Options) !CreateServiceNetworkVpcAssociationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "vpclattice");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateServiceNetworkVpcAssociationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("vpclattice", "VPC Lattice", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/servicenetworkvpcassociations";

    var body_buf: std.ArrayList(u8) = .{};
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

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateServiceNetworkVpcAssociationOutput {
    var result: CreateServiceNetworkVpcAssociationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateServiceNetworkVpcAssociationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
