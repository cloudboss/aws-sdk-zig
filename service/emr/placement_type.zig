/// The Amazon EC2 Availability Zone configuration of the cluster (job flow).
pub const PlacementType = struct {
    /// The Amazon EC2 Availability Zone for the cluster. `AvailabilityZone`
    /// is used for uniform instance groups, while `AvailabilityZones` (plural) is
    /// used
    /// for instance fleets.
    availability_zone: ?[]const u8,

    /// When multiple Availability Zones are specified, Amazon EMR evaluates them
    /// and
    /// launches instances in the optimal Availability Zone. `AvailabilityZones` is
    /// used
    /// for instance fleets, while `AvailabilityZone` (singular) is used for uniform
    /// instance groups.
    ///
    /// The instance fleet configuration is available only in Amazon EMR releases
    /// 4.8.0 and later, excluding 5.0.x versions.
    availability_zones: ?[]const []const u8,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .availability_zones = "AvailabilityZones",
    };
};
