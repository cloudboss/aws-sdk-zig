const OrganizationIntegration = @import("organization_integration.zig").OrganizationIntegration;

/// Lists the settings defined for discovering Linux subscriptions.
pub const LinuxSubscriptionsDiscoverySettings = struct {
    /// Details if you have enabled resource discovery across your accounts in
    /// Organizations.
    organization_integration: OrganizationIntegration,

    /// The Regions in which to discover data for Linux subscriptions.
    source_regions: []const []const u8,

    pub const json_field_names = .{
        .organization_integration = "OrganizationIntegration",
        .source_regions = "SourceRegions",
    };
};
