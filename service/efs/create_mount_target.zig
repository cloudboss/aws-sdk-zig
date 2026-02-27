const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;

pub const CreateMountTargetInput = struct {
    /// The ID of the file system for which to create the mount target.
    file_system_id: []const u8,

    /// If the IP address type for the mount target is IPv4, then specify the IPv4
    /// address within
    /// the address range of the specified subnet.
    ip_address: ?[]const u8 = null,

    /// Specify the type of IP address of the mount target you are creating. Options
    /// are IPv4,
    /// dual stack, or IPv6. If you don’t specify an IpAddressType, then IPv4 is
    /// used.
    ///
    /// * IPV4_ONLY – Create mount target with IPv4 only subnet or dual-stack
    ///   subnet.
    ///
    /// * DUAL_STACK – Create mount target with dual-stack subnet.
    ///
    /// * IPV6_ONLY – Create mount target with IPv6 only subnet.
    ///
    /// Creating IPv6 mount target only ENI in dual-stack subnet is not supported.
    ip_address_type: ?IpAddressType = null,

    /// If the IP address type for the mount target is IPv6, then specify the IPv6
    /// address within
    /// the address range of the specified subnet.
    ipv_6_address: ?[]const u8 = null,

    /// VPC security group IDs, of the form `sg-xxxxxxxx`. These must be for the
    /// same
    /// VPC as the subnet specified. The maximum number of security groups depends
    /// on account quota.
    /// For more information, see [Amazon VPC
    /// Quotas](https://docs.aws.amazon.com/vpc/latest/userguide/amazon-vpc-limits.html)
    /// in the *Amazon VPC User Guide* (see the **Security Groups**
    /// table).
    security_groups: ?[]const []const u8 = null,

    /// The ID of the subnet to add the mount target in. For One Zone file systems,
    /// use the subnet
    /// that is associated with the file system's Availability Zone.
    subnet_id: []const u8,

    pub const json_field_names = .{
        .file_system_id = "FileSystemId",
        .ip_address = "IpAddress",
        .ip_address_type = "IpAddressType",
        .ipv_6_address = "Ipv6Address",
        .security_groups = "SecurityGroups",
        .subnet_id = "SubnetId",
    };
};

pub const CreateMountTargetOutput = struct {
    /// The unique and consistent identifier of the Availability Zone that the mount
    /// target resides in.
    /// For example, `use1-az1` is an AZ ID for the us-east-1 Region and it
    /// has the same location in every Amazon Web Services account.
    availability_zone_id: ?[]const u8 = null,

    /// The name of the Availability Zone in which the mount target is located.
    /// Availability Zones are
    /// independently mapped to names for each Amazon Web Services account. For
    /// example, the
    /// Availability Zone `us-east-1a` for your Amazon Web Services account might
    /// not be the
    /// same location as `us-east-1a` for another Amazon Web Services account.
    availability_zone_name: ?[]const u8 = null,

    /// The ID of the file system for which the mount target is intended.
    file_system_id: []const u8,

    /// Address at which the file system can be mounted by using the mount target.
    ip_address: ?[]const u8 = null,

    /// The IPv6 address for the mount target.
    ipv_6_address: ?[]const u8 = null,

    /// Lifecycle state of the mount target.
    life_cycle_state: LifeCycleState,

    /// System-assigned mount target ID.
    mount_target_id: []const u8,

    /// The ID of the network interface that Amazon EFS created when it created the
    /// mount
    /// target.
    network_interface_id: ?[]const u8 = null,

    /// Amazon Web Services account ID that owns the resource.
    owner_id: ?[]const u8 = null,

    /// The ID of the mount target's subnet.
    subnet_id: []const u8,

    /// The virtual private cloud (VPC) ID that the mount target is configured in.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone_id = "AvailabilityZoneId",
        .availability_zone_name = "AvailabilityZoneName",
        .file_system_id = "FileSystemId",
        .ip_address = "IpAddress",
        .ipv_6_address = "Ipv6Address",
        .life_cycle_state = "LifeCycleState",
        .mount_target_id = "MountTargetId",
        .network_interface_id = "NetworkInterfaceId",
        .owner_id = "OwnerId",
        .subnet_id = "SubnetId",
        .vpc_id = "VpcId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMountTargetInput, options: Options) !CreateMountTargetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "efs");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateMountTargetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("efs", "EFS", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/2015-02-01/mount-targets";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"FileSystemId\":");
    try aws.json.writeValue(@TypeOf(input.file_system_id), input.file_system_id, alloc, &body_buf);
    has_prev = true;
    if (input.ip_address) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"IpAddress\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.ip_address_type) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"IpAddressType\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.ipv_6_address) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Ipv6Address\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.security_groups) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SecurityGroups\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"SubnetId\":");
    try aws.json.writeValue(@TypeOf(input.subnet_id), input.subnet_id, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateMountTargetOutput {
    var result: CreateMountTargetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateMountTargetOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessPointAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .access_point_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccessPointLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .access_point_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AccessPointNotFound")) {
        return .{ .arena = arena, .kind = .{ .access_point_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "AvailabilityZonesMismatch")) {
        return .{ .arena = arena, .kind = .{ .availability_zones_mismatch = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequest")) {
        return .{ .arena = arena, .kind = .{ .bad_request = .{
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
    if (std.mem.eql(u8, error_code, "DependencyTimeout")) {
        return .{ .arena = arena, .kind = .{ .dependency_timeout = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileSystemAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .file_system_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileSystemInUse")) {
        return .{ .arena = arena, .kind = .{ .file_system_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileSystemLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .file_system_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "FileSystemNotFound")) {
        return .{ .arena = arena, .kind = .{ .file_system_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncorrectFileSystemLifeCycleState")) {
        return .{ .arena = arena, .kind = .{ .incorrect_file_system_life_cycle_state = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IncorrectMountTargetState")) {
        return .{ .arena = arena, .kind = .{ .incorrect_mount_target_state = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InsufficientThroughputCapacity")) {
        return .{ .arena = arena, .kind = .{ .insufficient_throughput_capacity = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidPolicyException")) {
        return .{ .arena = arena, .kind = .{ .invalid_policy_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "IpAddressInUse")) {
        return .{ .arena = arena, .kind = .{ .ip_address_in_use = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MountTargetConflict")) {
        return .{ .arena = arena, .kind = .{ .mount_target_conflict = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "MountTargetNotFound")) {
        return .{ .arena = arena, .kind = .{ .mount_target_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NetworkInterfaceLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .network_interface_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NoFreeAddressesInSubnet")) {
        return .{ .arena = arena, .kind = .{ .no_free_addresses_in_subnet = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "PolicyNotFound")) {
        return .{ .arena = arena, .kind = .{ .policy_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicationAlreadyExists")) {
        return .{ .arena = arena, .kind = .{ .replication_already_exists = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ReplicationNotFound")) {
        return .{ .arena = arena, .kind = .{ .replication_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SecurityGroupLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .security_group_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SecurityGroupNotFound")) {
        return .{ .arena = arena, .kind = .{ .security_group_not_found = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "SubnetNotFound")) {
        return .{ .arena = arena, .kind = .{ .subnet_not_found = .{
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
    if (std.mem.eql(u8, error_code, "ThroughputLimitExceeded")) {
        return .{ .arena = arena, .kind = .{ .throughput_limit_exceeded = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequests")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnsupportedAvailabilityZone")) {
        return .{ .arena = arena, .kind = .{ .unsupported_availability_zone = .{
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
