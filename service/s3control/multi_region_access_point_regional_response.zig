/// Status information for a single Multi-Region Access Point Region.
pub const MultiRegionAccessPointRegionalResponse = struct {
    /// The name of the Region in the Multi-Region Access Point.
    name: ?[]const u8,

    /// The current status of the Multi-Region Access Point in this Region.
    request_status: ?[]const u8,
};
