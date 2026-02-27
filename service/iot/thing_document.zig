const aws = @import("aws");

const ThingConnectivity = @import("thing_connectivity.zig").ThingConnectivity;

/// The thing search index document.
pub const ThingDocument = struct {
    /// The attributes.
    attributes: ?[]const aws.map.StringMapEntry,

    /// Indicates whether the thing is connected to the Amazon Web Services IoT Core
    /// service.
    connectivity: ?ThingConnectivity,

    /// Contains Device Defender data.
    ///
    /// For more information about Device Defender, see [Device
    /// Defender](https://docs.aws.amazon.com/iot/latest/developerguide/device-defender.html).
    device_defender: ?[]const u8,

    /// The unnamed shadow and named shadow.
    ///
    /// For more information about shadows, see [IoT Device Shadow
    /// service.](https://docs.aws.amazon.com/iot/latest/developerguide/iot-device-shadows.html)
    shadow: ?[]const u8,

    /// Thing group and billing group names.
    thing_group_names: ?[]const []const u8,

    /// The thing ID.
    thing_id: ?[]const u8,

    /// The thing name.
    thing_name: ?[]const u8,

    /// The thing type name.
    thing_type_name: ?[]const u8,

    pub const json_field_names = .{
        .attributes = "attributes",
        .connectivity = "connectivity",
        .device_defender = "deviceDefender",
        .shadow = "shadow",
        .thing_group_names = "thingGroupNames",
        .thing_id = "thingId",
        .thing_name = "thingName",
        .thing_type_name = "thingTypeName",
    };
};
