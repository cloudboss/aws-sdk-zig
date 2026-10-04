const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Capacity = @import("capacity.zig").Capacity;
const UnlockState = @import("unlock_state.zig").UnlockState;
const PhysicalNetworkInterface = @import("physical_network_interface.zig").PhysicalNetworkInterface;
const SoftwareInformation = @import("software_information.zig").SoftwareInformation;

pub const DescribeDeviceInput = struct {
    /// The ID of the device that you are checking the information of.
    managed_device_id: []const u8,

    pub const json_field_names = .{
        .managed_device_id = "managedDeviceId",
    };
};

pub const DescribeDeviceOutput = struct {
    /// The ID of the job used when ordering the device.
    associated_with_job: ?[]const u8 = null,

    /// The hardware specifications of the device.
    device_capacities: ?[]const Capacity = null,

    /// The current state of the device.
    device_state: ?UnlockState = null,

    /// The type of Amazon Web Services Snow Family device.
    device_type: ?[]const u8 = null,

    /// When the device last contacted the Amazon Web Services Cloud. Indicates that
    /// the device is
    /// online.
    last_reached_out_at: ?i64 = null,

    /// When the device last pushed an update to the Amazon Web Services Cloud.
    /// Indicates when the device cache
    /// was refreshed.
    last_updated_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the device.
    managed_device_arn: ?[]const u8 = null,

    /// The ID of the device that you checked the information for.
    managed_device_id: ?[]const u8 = null,

    /// The network interfaces available on the device.
    physical_network_interfaces: ?[]const PhysicalNetworkInterface = null,

    /// The software installed on the device.
    software: ?SoftwareInformation = null,

    /// Optional metadata that you assign to a resource. You can use tags to
    /// categorize a resource
    /// in different ways, such as by purpose, owner, or environment.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .associated_with_job = "associatedWithJob",
        .device_capacities = "deviceCapacities",
        .device_state = "deviceState",
        .device_type = "deviceType",
        .last_reached_out_at = "lastReachedOutAt",
        .last_updated_at = "lastUpdatedAt",
        .managed_device_arn = "managedDeviceArn",
        .managed_device_id = "managedDeviceId",
        .physical_network_interfaces = "physicalNetworkInterfaces",
        .software = "software",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDeviceInput, options: CallOptions) !DescribeDeviceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "snow-device-management", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDeviceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("snow-device-management", "Snow Device Management", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/managed-device/");
    try path_buf.appendSlice(allocator, input.managed_device_id);
    try path_buf.appendSlice(allocator, "/describe");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDeviceOutput {
    var result: DescribeDeviceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeDeviceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
