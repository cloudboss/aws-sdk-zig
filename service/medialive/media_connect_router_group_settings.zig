/// Media Connect Router Group Settings
pub const MediaConnectRouterGroupSettings = struct {
    /// The names of the Availability Zones in which to write output to MediaConnect
    /// Router.
    availability_zones: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
    };
};
