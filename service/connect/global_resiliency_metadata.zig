/// Information about the global resiliency configuration for the contact,
/// including traffic distribution details.
pub const GlobalResiliencyMetadata = struct {
    /// The current AWS region in which the contact is active. This indicates where
    /// the contact is being processed in real-time.
    active_region: ?[]const u8 = null,

    /// The AWS region where the contact was originally created and initiated. This
    /// may differ from the ActiveRegion if the contact has been transferred across
    /// regions.
    origin_region: ?[]const u8 = null,

    /// The identifier of the traffic distribution group.
    traffic_distribution_group_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_region = "ActiveRegion",
        .origin_region = "OriginRegion",
        .traffic_distribution_group_id = "TrafficDistributionGroupId",
    };
};
