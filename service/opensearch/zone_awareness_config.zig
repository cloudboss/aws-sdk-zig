/// The zone awareness configuration for an Amazon OpenSearch Service domain.
pub const ZoneAwarenessConfig = struct {
    /// If you enabled multiple Availability Zones, this value is the number of
    /// zones that you
    /// want the domain to use. Valid values are `2` and `3`. If your
    /// domain is provisioned within a VPC, this value be equal to number of
    /// subnets.
    availability_zone_count: ?i32,

    pub const json_field_names = .{
        .availability_zone_count = "AvailabilityZoneCount",
    };
};
