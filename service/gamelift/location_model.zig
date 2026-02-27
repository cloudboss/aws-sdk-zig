const PingBeacon = @import("ping_beacon.zig").PingBeacon;

/// Properties of a location, which can include its name, ARN (for custom
/// locations), and
/// ping beacon information.
pub const LocationModel = struct {
    /// The Amazon Resource Name
    /// ([ARN](https://docs.aws.amazon.com/AmazonS3/latest/dev/s3-arn-format.html))
    /// that is assigned to a custom location resource and uniquely identifies it.
    /// ARNs are unique across all Regions. Format is
    /// `arn:aws:gamelift:::location/location-a1234567-b8c9-0d1e-2fa3-b45c6d7e8912`.
    location_arn: ?[]const u8,

    /// The location's name.
    location_name: ?[]const u8,

    /// Information about the UDP ping beacon for this location.
    ping_beacon: ?PingBeacon,

    pub const json_field_names = .{
        .location_arn = "LocationArn",
        .location_name = "LocationName",
        .ping_beacon = "PingBeacon",
    };
};
