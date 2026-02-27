/// Specifies the zone awareness configuration for the domain cluster, such as
/// the number of availability zones.
pub const ZoneAwarenessConfig = struct {
    /// An integer value to indicate the number of availability zones for a domain
    /// when zone awareness is enabled. This should be equal to number of subnets if
    /// VPC endpoints is enabled
    availability_zone_count: ?i32,

    pub const json_field_names = .{
        .availability_zone_count = "AvailabilityZoneCount",
    };
};
