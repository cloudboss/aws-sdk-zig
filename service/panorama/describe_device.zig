const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDeviceInput, options: Options) !DescribeDeviceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "panorama");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeDeviceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("panorama", "Panorama", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/devices/");
    try path_buf.appendSlice(alloc, input.device_id);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeDeviceOutput {
    var result: DescribeDeviceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeDeviceOutput, body, alloc);
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
