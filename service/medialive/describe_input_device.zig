const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InputDeviceConnectionState = @import("input_device_connection_state.zig").InputDeviceConnectionState;
const DeviceSettingsSyncState = @import("device_settings_sync_state.zig").DeviceSettingsSyncState;
const DeviceUpdateStatus = @import("device_update_status.zig").DeviceUpdateStatus;
const InputDeviceHdSettings = @import("input_device_hd_settings.zig").InputDeviceHdSettings;
const InputDeviceNetworkSettings = @import("input_device_network_settings.zig").InputDeviceNetworkSettings;
const InputDeviceOutputType = @import("input_device_output_type.zig").InputDeviceOutputType;
const InputDeviceType = @import("input_device_type.zig").InputDeviceType;
const InputDeviceUhdSettings = @import("input_device_uhd_settings.zig").InputDeviceUhdSettings;

pub const DescribeInputDeviceInput = struct {
    /// The unique ID of this input device. For example, hd-123456789abcdef.
    input_device_id: []const u8,

    pub const json_field_names = .{
        .input_device_id = "InputDeviceId",
    };
};

pub const DescribeInputDeviceOutput = struct {
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
    type: ?InputDeviceType = null,

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
        .type = "Type",
        .uhd_device_settings = "UhdDeviceSettings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInputDeviceInput, options: CallOptions) !DescribeInputDeviceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medialive", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInputDeviceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/inputDevices/");
    try path_buf.appendSlice(allocator, input.input_device_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInputDeviceOutput {
    const result: DescribeInputDeviceOutput = try aws.json.parseJsonObject(
        DescribeInputDeviceOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
