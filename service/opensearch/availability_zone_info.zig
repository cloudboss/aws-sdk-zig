const ZoneStatus = @import("zone_status.zig").ZoneStatus;

/// Information about an Availability Zone on a domain.
pub const AvailabilityZoneInfo = struct {
    /// The name of the Availability Zone.
    availability_zone_name: ?[]const u8,

    /// The number of data nodes active in the Availability Zone.
    available_data_node_count: ?[]const u8,

    /// The total number of data nodes configured in the Availability Zone.
    configured_data_node_count: ?[]const u8,

    /// The total number of primary and replica shards in the Availability Zone.
    total_shards: ?[]const u8,

    /// The total number of primary and replica shards that aren't allocated to any
    /// of the
    /// nodes in the Availability Zone.
    total_un_assigned_shards: ?[]const u8,

    /// The current state of the Availability Zone. Current options are `Active`
    /// and `StandBy`.
    ///
    /// * `Active` - Data nodes in the Availability Zone are in use.
    ///
    /// * `StandBy` - Data nodes in the Availability Zone are in a standby
    /// state.
    ///
    /// * `NotAvailable` - Unable to retrieve information.
    zone_status: ?ZoneStatus,

    pub const json_field_names = .{
        .availability_zone_name = "AvailabilityZoneName",
        .available_data_node_count = "AvailableDataNodeCount",
        .configured_data_node_count = "ConfiguredDataNodeCount",
        .total_shards = "TotalShards",
        .total_un_assigned_shards = "TotalUnAssignedShards",
        .zone_status = "ZoneStatus",
    };
};
