const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InputDeviceConfigurableSettings = @import("input_device_configurable_settings.zig").InputDeviceConfigurableSettings;
const InputDeviceConnectionState = @import("input_device_connection_state.zig").InputDeviceConnectionState;
const DeviceSettingsSyncState = @import("device_settings_sync_state.zig").DeviceSettingsSyncState;
const DeviceUpdateStatus = @import("device_update_status.zig").DeviceUpdateStatus;
const InputDeviceHdSettings = @import("input_device_hd_settings.zig").InputDeviceHdSettings;
const InputDeviceNetworkSettings = @import("input_device_network_settings.zig").InputDeviceNetworkSettings;
const InputDeviceOutputType = @import("input_device_output_type.zig").InputDeviceOutputType;
const InputDeviceType = @import("input_device_type.zig").InputDeviceType;
const InputDeviceUhdSettings = @import("input_device_uhd_settings.zig").InputDeviceUhdSettings;

pub const UpdateInputDeviceInput = struct {
    /// The Availability Zone you want associated with this input device.
    availability_zone: ?[]const u8 = null,

    /// The settings that you want to apply to the HD input device.
    hd_device_settings: ?InputDeviceConfigurableSettings = null,

    /// The unique ID of the input device. For example, hd-123456789abcdef.
    input_device_id: []const u8,

    /// The name that you assigned to this input device (not the unique ID).
    name: ?[]const u8 = null,

    /// The settings that you want to apply to the UHD input device.
    uhd_device_settings: ?InputDeviceConfigurableSettings = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .hd_device_settings = "HdDeviceSettings",
        .input_device_id = "InputDeviceId",
        .name = "Name",
        .uhd_device_settings = "UhdDeviceSettings",
    };
};

pub const UpdateInputDeviceOutput = struct {
    /// The unique ARN of the input device.
    arn: ?[]const u8 = null,

    /// The Availability Zone associated with this input device.
    availability_zone: ?[]const u8 = null,

    /// The state of the connection between the input device and AWS.
    connection_state: ?InputDeviceConnectionState = null,

    /// The status of the action to synchronize the device configuration. If you
    /// change the configuration of the input device (for example, the maximum
    /// bitrate), MediaLive sends the new data to the device. The device might not
    /// update itself immediately. SYNCED means the device has updated its
    /// configuration. SYNCING means that it has not updated its configuration.
    device_settings_sync_state: ?DeviceSettingsSyncState = null,

    /// The status of software on the input device.
    device_update_status: ?DeviceUpdateStatus = null,

    /// Settings that describe an input device that is type HD.
    hd_device_settings: ?InputDeviceHdSettings = null,

    /// The unique ID of the input device.
    id: ?[]const u8 = null,

    /// The network MAC address of the input device.
    mac_address: ?[]const u8 = null,

    /// An array of the ARNs for the MediaLive inputs attached to the device.
    /// Returned only if the outputType is MEDIALIVE_INPUT.
    medialive_input_arns: ?[]const []const u8 = null,

    /// A name that you specify for the input device.
    name: ?[]const u8 = null,

    /// The network settings for the input device.
    network_settings: ?InputDeviceNetworkSettings = null,

    /// The output attachment type of the input device. Specifies MEDIACONNECT_FLOW
    /// if this device is the source for a MediaConnect flow. Specifies
    /// MEDIALIVE_INPUT if this device is the source for a MediaLive input.
    output_type: ?InputDeviceOutputType = null,

    /// The unique serial number of the input device.
    serial_number: ?[]const u8 = null,

    /// A collection of key-value pairs.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of the input device.
    @"type": ?InputDeviceType = null,

    /// Settings that describe an input device that is type UHD.
    uhd_device_settings: ?InputDeviceUhdSettings = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .availability_zone = "AvailabilityZone",
        .connection_state = "ConnectionState",
        .device_settings_sync_state = "DeviceSettingsSyncState",
        .device_update_status = "DeviceUpdateStatus",
        .hd_device_settings = "HdDeviceSettings",
        .id = "Id",
        .mac_address = "MacAddress",
        .medialive_input_arns = "MedialiveInputArns",
        .name = "Name",
        .network_settings = "NetworkSettings",
        .output_type = "OutputType",
        .serial_number = "SerialNumber",
        .tags = "Tags",
        .@"type" = "Type",
        .uhd_device_settings = "UhdDeviceSettings",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateInputDeviceInput, options: Options) !UpdateInputDeviceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "medialive");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateInputDeviceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/prod/inputDevices/");
    try path_buf.appendSlice(allocator, input.input_device_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.availability_zone) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AvailabilityZone\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.hd_device_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"HdDeviceSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.uhd_device_settings) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"UhdDeviceSettings\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateInputDeviceOutput {
    var result: UpdateInputDeviceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateInputDeviceOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "BadGatewayException")) {
        return .{ .arena = arena, .kind = .{ .bad_gateway_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "ForbiddenException")) {
        return .{ .arena = arena, .kind = .{ .forbidden_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "GatewayTimeoutException")) {
        return .{ .arena = arena, .kind = .{ .gateway_timeout_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "UnprocessableEntityException")) {
        return .{ .arena = arena, .kind = .{ .unprocessable_entity_exception = .{
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
