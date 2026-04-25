const RegionGeography = @import("region_geography.zig").RegionGeography;

/// Describes a Region.
pub const Region = struct {
    /// The Region service endpoint.
    endpoint: ?[]const u8 = null,

    /// The geography information for the Region. The geography is returned as a
    /// list.
    geography: ?[]const RegionGeography = null,

    /// The Region opt-in status. The possible values are `opt-in-not-required`,
    /// `opted-in`, and
    /// `not-opted-in`.
    opt_in_status: ?[]const u8 = null,

    /// The name of the Region.
    region_name: ?[]const u8 = null,
};
