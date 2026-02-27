/// Placeholder documentation for RouterDestinationSettings
pub const RouterDestinationSettings = struct {
    /// Availability Zone for this MediaConnect Router destination.
    availability_zone_name: []const u8,

    pub const json_field_names = .{
        .availability_zone_name = "AvailabilityZoneName",
    };
};
