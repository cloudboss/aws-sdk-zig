const aws = @import("aws");

const InputDeviceConnectionState = @import("input_device_connection_state.zig").InputDeviceConnectionState;
const DeviceSettingsSyncState = @import("device_settings_sync_state.zig").DeviceSettingsSyncState;
const DeviceUpdateStatus = @import("device_update_status.zig").DeviceUpdateStatus;
const InputDeviceHdSettings = @import("input_device_hd_settings.zig").InputDeviceHdSettings;
const InputDeviceNetworkSettings = @import("input_device_network_settings.zig").InputDeviceNetworkSettings;
const InputDeviceOutputType = @import("input_device_output_type.zig").InputDeviceOutputType;
const InputDeviceType = @import("input_device_type.zig").InputDeviceType;
const InputDeviceUhdSettings = @import("input_device_uhd_settings.zig").InputDeviceUhdSettings;

/// Details of the input device.
pub const InputDeviceSummary = struct {
    /// The unique ARN of the input device.
    arn: ?[]const u8,

    /// The Availability Zone associated with this input device.
    availability_zone: ?[]const u8,

    /// The state of the connection between the input device and AWS.
    connection_state: ?InputDeviceConnectionState,

    /// The status of the action to synchronize the device configuration. If you
    /// change the configuration of the input device (for example, the maximum
    /// bitrate), MediaLive sends the new data to the device. The device might not
    /// update itself immediately. SYNCED means the device has updated its
    /// configuration. SYNCING means that it has not updated its configuration.
    device_settings_sync_state: ?DeviceSettingsSyncState,

    /// The status of software on the input device.
    device_update_status: ?DeviceUpdateStatus,

    /// Settings that describe an input device that is type HD.
    hd_device_settings: ?InputDeviceHdSettings,

    /// The unique ID of the input device.
    id: ?[]const u8,

    /// The network MAC address of the input device.
    mac_address: ?[]const u8,

    /// An array of the ARNs for the MediaLive inputs attached to the device.
    /// Returned only if the outputType is MEDIALIVE_INPUT.
    medialive_input_arns: ?[]const []const u8,

    /// A name that you specify for the input device.
    name: ?[]const u8,

    /// Network settings for the input device.
    network_settings: ?InputDeviceNetworkSettings,

    /// The output attachment type of the input device. Specifies MEDIACONNECT_FLOW
    /// if this device is the source for a MediaConnect flow. Specifies
    /// MEDIALIVE_INPUT if this device is the source for a MediaLive input.
    output_type: ?InputDeviceOutputType,

    /// The unique serial number of the input device.
    serial_number: ?[]const u8,

    /// A collection of key-value pairs.
    tags: ?[]const aws.map.StringMapEntry,

    /// The type of the input device.
    @"type": ?InputDeviceType,

    /// Settings that describe an input device that is type UHD.
    uhd_device_settings: ?InputDeviceUhdSettings,

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
