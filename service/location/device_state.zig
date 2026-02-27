const PositionalAccuracy = @import("positional_accuracy.zig").PositionalAccuracy;
const CellSignals = @import("cell_signals.zig").CellSignals;
const WiFiAccessPoint = @import("wi_fi_access_point.zig").WiFiAccessPoint;

/// The device's position, IP address, and Wi-Fi access points.
pub const DeviceState = struct {
    accuracy: ?PositionalAccuracy,

    /// The cellular network infrastructure that the device is connected to.
    cell_signals: ?CellSignals,

    /// The device identifier.
    device_id: []const u8,

    /// The device's Ipv4 address.
    ipv_4_address: ?[]const u8,

    /// The last known device position.
    position: []const f64,

    /// The timestamp at which the device's position was determined. Uses [ ISO 8601
    /// ](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    sample_time: i64,

    /// The Wi-Fi access points the device is using.
    wi_fi_access_points: ?[]const WiFiAccessPoint,

    pub const json_field_names = .{
        .accuracy = "Accuracy",
        .cell_signals = "CellSignals",
        .device_id = "DeviceId",
        .ipv_4_address = "Ipv4Address",
        .position = "Position",
        .sample_time = "SampleTime",
        .wi_fi_access_points = "WiFiAccessPoints",
    };
};
