const PublicAccessBlockConfiguration = @import("public_access_block_configuration.zig").PublicAccessBlockConfiguration;
const RegionReport = @import("region_report.zig").RegionReport;
const MultiRegionAccessPointStatus = @import("multi_region_access_point_status.zig").MultiRegionAccessPointStatus;

/// A collection of statuses for a Multi-Region Access Point in the various
/// Regions it supports.
pub const MultiRegionAccessPointReport = struct {
    /// The alias for the Multi-Region Access Point. For more information about the
    /// distinction between the name
    /// and the alias of an Multi-Region Access Point, see [Rules for naming Amazon
    /// S3 Multi-Region Access
    /// Points](https://docs.aws.amazon.com/AmazonS3/latest/userguide/CreatingMultiRegionAccessPoints.html#multi-region-access-point-naming).
    alias: ?[]const u8 = null,

    /// When the Multi-Region Access Point create request was received.
    created_at: ?i64 = null,

    /// The name of the Multi-Region Access Point.
    name: ?[]const u8 = null,

    public_access_block: ?PublicAccessBlockConfiguration = null,

    /// A collection of the Regions and buckets associated with the Multi-Region
    /// Access Point.
    regions: ?[]const RegionReport = null,

    /// The current status of the Multi-Region Access Point.
    ///
    /// `CREATING` and `DELETING` are temporary states that exist while
    /// the request is propagating and being completed. If a Multi-Region Access
    /// Point has a status of
    /// `PARTIALLY_CREATED`, you can retry creation or send a request to delete the
    /// Multi-Region Access Point. If a Multi-Region Access Point has a status of
    /// `PARTIALLY_DELETED`, you can retry a delete
    /// request to finish the deletion of the Multi-Region Access Point.
    status: ?MultiRegionAccessPointStatus = null,
};
