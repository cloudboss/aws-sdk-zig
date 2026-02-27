/// Configuration options for zone awareness.
pub const AwsOpenSearchServiceDomainClusterConfigZoneAwarenessConfigDetails = struct {
    /// The number of Availability Zones that the domain uses. Valid values are `2`
    /// or `3`. The default is `2`.
    availability_zone_count: ?i32,

    pub const json_field_names = .{
        .availability_zone_count = "AvailabilityZoneCount",
    };
};
