/// Defines the Amazon Web Services Regions that the specified Firewall Manager
/// administrator can manage.
pub const RegionScope = struct {
    /// Allows the specified Firewall Manager administrator to manage all Amazon Web
    /// Services Regions.
    all_regions_enabled: bool = false,

    /// The Amazon Web Services Regions that the specified Firewall Manager
    /// administrator can perform actions in.
    regions: ?[]const []const u8,

    pub const json_field_names = .{
        .all_regions_enabled = "AllRegionsEnabled",
        .regions = "Regions",
    };
};
