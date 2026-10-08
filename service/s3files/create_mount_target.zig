const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;

pub const CreateMountTargetInput = struct {
    /// The ID or Amazon Resource Name (ARN) of the S3 File System to create the
    /// mount target for.
    file_system_id: []const u8,

    /// The IP address type for the mount target. If not specified, `IPV4_ONLY` is
    /// used. The IP address type must match the IP configuration of the specified
    /// subnet.
    ip_address_type: ?IpAddressType = null,

    /// A specific IPv4 address to assign to the mount target. If not specified and
    /// the IP address type supports IPv4, an address is automatically assigned from
    /// the subnet's available IPv4 address range. The address must be within the
    /// subnet's CIDR block and not already in use.
    ipv_4_address: ?[]const u8 = null,

    /// A specific IPv6 address to assign to the mount target. If not specified and
    /// the IP address type supports IPv6, an address is automatically assigned from
    /// the subnet's available IPv6 address range. The address must be within the
    /// subnet's IPv6 CIDR block and not already in use.
    ipv_6_address: ?[]const u8 = null,

    /// An array of VPC security group IDs to associate with the mount target's
    /// network interface. These security groups control network access to the mount
    /// target. If not specified, the default security group for the subnet's VPC is
    /// used. All security groups must belong to the same VPC as the subnet.
    security_groups: ?[]const []const u8 = null,

    /// The ID of the subnet where the mount target will be created. The subnet must
    /// be in the same Amazon Web Services Region as the file system. For file
    /// systems with regional availability, you can create mount targets in any
    /// subnet within the Region. The subnet determines the Availability Zone where
    /// the mount target will be located.
    subnet_id: []const u8,

    pub const json_field_names = .{
        .file_system_id = "fileSystemId",
        .ip_address_type = "ipAddressType",
        .ipv_4_address = "ipv4Address",
        .ipv_6_address = "ipv6Address",
        .security_groups = "securityGroups",
        .subnet_id = "subnetId",
    };
};

pub const CreateMountTargetOutput = struct {
    /// The unique and consistent identifier of the Availability Zone where the
    /// mount target is located. For example, `use1-az1` is an Availability Zone ID
    /// for the `us-east-1` Amazon Web Services Region, and it has the same location
    /// in every Amazon Web Services account.
    availability_zone_id: ?[]const u8 = null,

    /// The ID of the S3 File System associated with the mount target.
    file_system_id: ?[]const u8 = null,

    /// The IPv4 address assigned to the mount target.
    ipv_4_address: ?[]const u8 = null,

    /// The IPv6 address assigned to the mount target.
    ipv_6_address: ?[]const u8 = null,

    /// The ID of the mount target, assigned by S3 Files. This ID is used to
    /// reference the mount target in subsequent API calls.
    mount_target_id: []const u8,

    /// The ID of the network interface that S3 Files created when it created the
    /// mount target. This network interface is managed by the service.
    network_interface_id: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the mount target owner.
    owner_id: []const u8,

    /// The security groups associated with the mount target's network interface.
    security_groups: ?[]const []const u8 = null,

    /// The lifecycle state of the mount target. Valid values are: `AVAILABLE` (the
    /// mount target is available for use), `CREATING` (the mount target is being
    /// created), `DELETING` (the mount target is being deleted), `DELETED` (the
    /// mount target has been deleted), or `ERROR` (the mount target is in an error
    /// state), or `UPDATING` (the mount target is being updated).
    status: ?LifeCycleState = null,

    /// Additional information about the mount target status. This field provides
    /// more details when the status is `ERROR`, or during state transitions.
    status_message: ?[]const u8 = null,

    /// The ID of the subnet where the mount target is located.
    subnet_id: []const u8,

    /// The ID of the VPC where the mount target is located.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone_id = "availabilityZoneId",
        .file_system_id = "fileSystemId",
        .ipv_4_address = "ipv4Address",
        .ipv_6_address = "ipv6Address",
        .mount_target_id = "mountTargetId",
        .network_interface_id = "networkInterfaceId",
        .owner_id = "ownerId",
        .security_groups = "securityGroups",
        .status = "status",
        .status_message = "statusMessage",
        .subnet_id = "subnetId",
        .vpc_id = "vpcId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMountTargetInput, options: CallOptions) !CreateMountTargetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3files", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMountTargetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3files", "S3Files", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/mount-targets";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"fileSystemId\":");
    try aws.json.writeValue(@TypeOf(input.file_system_id), input.file_system_id, allocator, &body_buf);
    has_prev = true;
    if (input.ip_address_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ipAddressType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ipv_4_address) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ipv4Address\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ipv_6_address) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ipv6Address\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.security_groups) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"securityGroups\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"subnetId\":");
    try aws.json.writeValue(@TypeOf(input.subnet_id), input.subnet_id, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMountTargetOutput {
    const result: CreateMountTargetOutput = try aws.json.parseJsonObject(
        CreateMountTargetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
