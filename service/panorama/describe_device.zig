const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AlternateSoftwareMetadata = @import("alternate_software_metadata.zig").AlternateSoftwareMetadata;
const DeviceBrand = @import("device_brand.zig").DeviceBrand;
const NetworkStatus = @import("network_status.zig").NetworkStatus;
const DeviceAggregatedStatus = @import("device_aggregated_status.zig").DeviceAggregatedStatus;
const DeviceConnectionStatus = @import("device_connection_status.zig").DeviceConnectionStatus;
const LatestDeviceJob = @import("latest_device_job.zig").LatestDeviceJob;
const NetworkPayload = @import("network_payload.zig").NetworkPayload;
const DeviceStatus = @import("device_status.zig").DeviceStatus;
const DeviceType = @import("device_type.zig").DeviceType;

pub const DescribeDeviceInput = struct {
    /// The device's ID.
    device_id: []const u8,

    pub const json_field_names = .{
        .device_id = "DeviceId",
    };
};

pub const DescribeDeviceOutput = struct {
    /// Beta software releases available for the device.
    alternate_softwares: ?[]const AlternateSoftwareMetadata = null,

    /// The device's ARN.
    arn: ?[]const u8 = null,

    /// The device's maker.
    brand: ?DeviceBrand = null,

    /// When the device was created.
    created_time: ?i64 = null,

    /// The device's networking status.
    current_networking_status: ?NetworkStatus = null,

    /// The device's current software version.
    current_software: ?[]const u8 = null,

    /// The device's description.
    description: ?[]const u8 = null,

    /// A device's aggregated status. Including the device's connection status,
    /// provisioning status, and lease status.
    device_aggregated_status: ?DeviceAggregatedStatus = null,

    /// The device's connection status.
    device_connection_status: ?DeviceConnectionStatus = null,

    /// The device's ID.
    device_id: ?[]const u8 = null,

    /// The most recent beta software release.
    latest_alternate_software: ?[]const u8 = null,

    /// A device's latest job. Includes the target image version, and the job
    /// status.
    latest_device_job: ?LatestDeviceJob = null,

    /// The latest software version available for the device.
    latest_software: ?[]const u8 = null,

    /// The device's lease expiration time.
    lease_expiration_time: ?i64 = null,

    /// The device's name.
    name: ?[]const u8 = null,

    /// The device's networking configuration.
    networking_configuration: ?NetworkPayload = null,

    /// The device's provisioning status.
    provisioning_status: ?DeviceStatus = null,

    /// The device's serial number.
    serial_number: ?[]const u8 = null,

    /// The device's tags.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The device's type.
    @"type": ?DeviceType = null,

    pub const json_field_names = .{
        .alternate_softwares = "AlternateSoftwares",
        .arn = "Arn",
        .brand = "Brand",
        .created_time = "CreatedTime",
        .current_networking_status = "CurrentNetworkingStatus",
        .current_software = "CurrentSoftware",
        .description = "Description",
        .device_aggregated_status = "DeviceAggregatedStatus",
        .device_connection_status = "DeviceConnectionStatus",
        .device_id = "DeviceId",
        .latest_alternate_software = "LatestAlternateSoftware",
        .latest_device_job = "LatestDeviceJob",
        .latest_software = "LatestSoftware",
        .lease_expiration_time = "LeaseExpirationTime",
        .name = "Name",
        .networking_configuration = "NetworkingConfiguration",
        .provisioning_status = "ProvisioningStatus",
        .serial_number = "SerialNumber",
        .tags = "Tags",
        .@"type" = "Type",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDeviceInput, options: CallOptions) !DescribeDeviceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "panorama", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("panorama", "Panorama", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/devices/");
    try path_buf.appendSlice(allocator, input.device_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDeviceOutput {
    var result: DescribeDeviceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeDeviceOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
