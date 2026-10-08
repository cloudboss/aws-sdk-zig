const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LifeCycleState = @import("life_cycle_state.zig").LifeCycleState;

pub const GetMountTargetInput = struct {
    /// The ID of the mount target to retrieve information for.
    mount_target_id: []const u8,

    pub const json_field_names = .{
        .mount_target_id = "mountTargetId",
    };
};

pub const GetMountTargetOutput = struct {
    /// The Availability Zone ID where the mount target is located.
    availability_zone_id: ?[]const u8 = null,

    /// The ID of the file system.
    file_system_id: ?[]const u8 = null,

    /// The IPv4 address of the mount target.
    ipv_4_address: ?[]const u8 = null,

    /// The IPv6 address of the mount target.
    ipv_6_address: ?[]const u8 = null,

    /// The ID of the mount target.
    mount_target_id: []const u8,

    /// The ID of the network interface associated with the mount target.
    network_interface_id: ?[]const u8 = null,

    /// The Amazon Web Services account ID of the mount target owner.
    owner_id: []const u8,

    /// The security groups associated with the mount target.
    security_groups: ?[]const []const u8 = null,

    /// The current status of the mount target.
    status: ?LifeCycleState = null,

    /// Additional information about the mount target status.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMountTargetInput, options: CallOptions) !GetMountTargetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMountTargetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3files", "S3Files", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/mount-targets/");
    try path_buf.appendSlice(allocator, input.mount_target_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMountTargetOutput {
    const result: GetMountTargetOutput = try aws.json.parseJsonObject(
        GetMountTargetOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
