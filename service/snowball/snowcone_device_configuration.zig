const WirelessConnection = @import("wireless_connection.zig").WirelessConnection;

/// Specifies the device configuration for an Snowball Edge job.
pub const SnowconeDeviceConfiguration = struct {
    /// Configures the wireless connection for the Snowball Edge device.
    wireless_connection: ?WirelessConnection,

    pub const json_field_names = .{
        .wireless_connection = "WirelessConnection",
    };
};
