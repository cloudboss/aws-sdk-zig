const AsyncErrorDetails = @import("async_error_details.zig").AsyncErrorDetails;
const MultiRegionAccessPointsAsyncResponse = @import("multi_region_access_points_async_response.zig").MultiRegionAccessPointsAsyncResponse;

/// A container for the response details that are returned when querying about
/// an
/// asynchronous request.
pub const AsyncResponseDetails = struct {
    /// Error details for an asynchronous request.
    error_details: ?AsyncErrorDetails = null,

    /// The details for the Multi-Region Access Point.
    multi_region_access_point_details: ?MultiRegionAccessPointsAsyncResponse = null,
};
