const MultiRegionAccessPointRegionalResponse = @import("multi_region_access_point_regional_response.zig").MultiRegionAccessPointRegionalResponse;

/// The Multi-Region Access Point details that are returned when querying about
/// an asynchronous request.
pub const MultiRegionAccessPointsAsyncResponse = struct {
    /// A collection of status information for the different Regions that a
    /// Multi-Region Access Point
    /// supports.
    regions: ?[]const MultiRegionAccessPointRegionalResponse = null,
};
