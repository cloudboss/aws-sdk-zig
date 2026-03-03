const aws = @import("aws");

const PositionalAccuracy = @import("positional_accuracy.zig").PositionalAccuracy;

/// Contains the tracker resource details.
pub const ListDevicePositionsResponseEntry = struct {
    /// The accuracy of the device position.
    accuracy: ?PositionalAccuracy = null,

    /// The ID of the device for this position.
    device_id: []const u8,

    /// The last known device position. Empty if no positions currently stored.
    position: []const f64,

    /// The properties associated with the position.
    position_properties: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp at which the device position was determined. Uses [ ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    sample_time: i64,

    pub const json_field_names = .{
        .accuracy = "Accuracy",
        .device_id = "DeviceId",
        .position = "Position",
        .position_properties = "PositionProperties",
        .sample_time = "SampleTime",
    };
};
