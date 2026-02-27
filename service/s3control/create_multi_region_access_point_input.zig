const PublicAccessBlockConfiguration = @import("public_access_block_configuration.zig").PublicAccessBlockConfiguration;
const Region = @import("region.zig").Region;

/// A container for the information associated with a
/// [CreateMultiRegionAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateMultiRegionAccessPoint.html) request.
pub const CreateMultiRegionAccessPointInput = struct {
    /// The name of the Multi-Region Access Point associated with this request.
    name: []const u8,

    public_access_block: ?PublicAccessBlockConfiguration,

    /// The buckets in different Regions that are associated with the Multi-Region
    /// Access Point.
    regions: []const Region,
};
