const aws = @import("aws");

const PositionalAccuracy = @import("positional_accuracy.zig").PositionalAccuracy;

/// Contains the position update details for a device.
pub const DevicePositionUpdate = struct {
    /// The accuracy of the device position.
    accuracy: ?PositionalAccuracy = null,

    /// The device associated to the position update.
    device_id: []const u8,

    /// The latest device position defined in [WGS
    /// 84](https://earth-info.nga.mil/index.php?dir=wgs84&action=wgs84) format: `[X
    /// or longitude, Y or latitude]`.
    position: []const f64,

    /// Associates one of more properties with the position update. A property is a
    /// key-value pair stored with the position update and added to any geofence
    /// event the update may trigger.
    ///
    /// Format: `"key" : "value"`
    position_properties: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp at which the device's position was determined. Uses [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`
    sample_time: i64,

    pub const json_field_names = .{
        .accuracy = "Accuracy",
        .device_id = "DeviceId",
        .position = "Position",
        .position_properties = "PositionProperties",
        .sample_time = "SampleTime",
    };
};
