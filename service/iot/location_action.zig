const LocationTimestamp = @import("location_timestamp.zig").LocationTimestamp;

/// The Amazon Location rule action sends device location updates from
/// an MQTT message to an Amazon Location tracker resource.
pub const LocationAction = struct {
    /// The unique ID of the device providing the location data.
    device_id: []const u8,

    /// A string that evaluates to a double value that represents the
    /// latitude of the device's location.
    latitude: []const u8,

    /// A string that evaluates to a double value that represents the
    /// longitude of the device's location.
    longitude: []const u8,

    /// The IAM role that grants permission to write to the Amazon Location
    /// resource.
    role_arn: []const u8,

    /// The time that the location data was sampled. The default value is
    /// the time the MQTT message was processed.
    timestamp: ?LocationTimestamp,

    /// The name of the tracker resource in Amazon Location in which the location is
    /// updated.
    tracker_name: []const u8,

    pub const json_field_names = .{
        .device_id = "deviceId",
        .latitude = "latitude",
        .longitude = "longitude",
        .role_arn = "roleArn",
        .timestamp = "timestamp",
        .tracker_name = "trackerName",
    };
};
