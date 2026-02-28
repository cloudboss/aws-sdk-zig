const MinimumHealthyHostsPerZoneType = @import("minimum_healthy_hosts_per_zone_type.zig").MinimumHealthyHostsPerZoneType;

/// Information about the minimum number of healthy instances per Availability
/// Zone.
pub const MinimumHealthyHostsPerZone = struct {
    /// The `type` associated with the `MinimumHealthyHostsPerZone`
    /// option.
    @"type": ?MinimumHealthyHostsPerZoneType,

    /// The `value` associated with the `MinimumHealthyHostsPerZone`
    /// option.
    value: i32 = 0,

    pub const json_field_names = .{
        .@"type" = "type",
        .value = "value",
    };
};
