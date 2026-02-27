/// Provides information about the Regions that are configured for multi-Region
/// replication.
pub const RegionsInfo = struct {
    /// Lists the Regions where the directory has been replicated, excluding the
    /// primary
    /// Region.
    additional_regions: ?[]const []const u8,

    /// The Region where the Managed Microsoft AD directory was originally created.
    primary_region: ?[]const u8,

    pub const json_field_names = .{
        .additional_regions = "AdditionalRegions",
        .primary_region = "PrimaryRegion",
    };
};
