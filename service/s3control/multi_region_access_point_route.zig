/// A structure for a Multi-Region Access Point that indicates where Amazon S3
/// traffic can be routed. Routes can be
/// either active or passive. Active routes can process Amazon S3 requests
/// through the Multi-Region Access Point, but
/// passive routes are not eligible to process Amazon S3 requests.
///
/// Each route contains the Amazon S3 bucket name and the Amazon Web Services
/// Region that the bucket is located
/// in. The route also includes the `TrafficDialPercentage` value, which shows
/// whether the bucket and Region are active (indicated by a value of `100`) or
/// passive (indicated by a value of `0`).
pub const MultiRegionAccessPointRoute = struct {
    /// The name of the Amazon S3 bucket for which you'll submit a routing
    /// configuration change.
    /// Either the `Bucket` or the `Region` value must be provided. If both
    /// are provided, the bucket must be in the specified Region.
    bucket: ?[]const u8,

    /// The Amazon Web Services Region to which you'll be submitting a routing
    /// configuration change. Either
    /// the `Bucket` or the `Region` value must be provided. If both are
    /// provided, the bucket must be in the specified Region.
    region: ?[]const u8,

    /// The traffic state for the specified bucket or Amazon Web Services Region.
    ///
    /// A value of `0` indicates a passive state, which means that no new traffic
    /// will be routed to the Region.
    ///
    /// A value of `100` indicates an active state, which means that traffic will be
    /// routed to the specified Region.
    ///
    /// When the routing configuration for a Region is changed from active to
    /// passive, any
    /// in-progress operations (uploads, copies, deletes, and so on) to the formerly
    /// active Region
    /// will continue to run to until a final success or failure status is reached.
    ///
    /// If all Regions in the routing configuration are designated as passive,
    /// you'll receive an
    /// `InvalidRequest` error.
    traffic_dial_percentage: i32,
};
