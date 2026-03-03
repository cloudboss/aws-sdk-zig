const aws = @import("aws");

const PositionalAccuracy = @import("positional_accuracy.zig").PositionalAccuracy;

/// Contains the device position details.
pub const DevicePosition = struct {
    /// The accuracy of the device position.
    accuracy: ?PositionalAccuracy = null,

    /// The device whose position you retrieved.
    device_id: ?[]const u8 = null,

    /// The last known device position.
    position: []const f64,

    /// The properties associated with the position.
    position_properties: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp for when the tracker resource received the device position in
    /// [ ISO 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    received_time: i64,

    /// The timestamp at which the device's position was determined. Uses [ ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    sample_time: i64,

    pub const json_field_names = .{
        .accuracy = "Accuracy",
        .device_id = "DeviceId",
        .position = "Position",
        .position_properties = "PositionProperties",
        .received_time = "ReceivedTime",
        .sample_time = "SampleTime",
    };
};
