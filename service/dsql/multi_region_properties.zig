/// Defines the structure for multi-Region cluster configurations, containing
/// the witness region and linked cluster settings.
pub const MultiRegionProperties = struct {
    /// The set of peered clusters that form the multi-Region cluster configuration.
    /// Each peered cluster represents a database instance in a different Region.
    clusters: ?[]const []const u8 = null,

    /// The Region that serves as the witness region for a multi-Region cluster. The
    /// witness Region helps maintain cluster consistency and quorum.
    witness_region: ?[]const u8 = null,

    pub const json_field_names = .{
        .clusters = "clusters",
        .witness_region = "witnessRegion",
    };
};
