const DeviceStatus = @import("device_status.zig").DeviceStatus;
const DeviceType = @import("device_type.zig").DeviceType;

/// Includes information about the device.
pub const DeviceSummary = struct {
    /// The ARN of the device.
    device_arn: []const u8,

    /// The name of the device.
    device_name: []const u8,

    /// The status of the device.
    device_status: DeviceStatus,

    /// The type of the device.
    device_type: DeviceType,

    /// The provider of the device.
    provider_name: []const u8,

    pub const json_field_names = .{
        .device_arn = "deviceArn",
        .device_name = "deviceName",
        .device_status = "deviceStatus",
        .device_type = "deviceType",
        .provider_name = "providerName",
    };
};
