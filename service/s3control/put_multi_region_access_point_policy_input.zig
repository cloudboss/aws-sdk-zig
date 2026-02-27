/// A container for the information associated with a
/// [PutMultiRegionAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutMultiRegionAccessPoint.html) request.
pub const PutMultiRegionAccessPointPolicyInput = struct {
    /// The name of the Multi-Region Access Point associated with the request.
    name: []const u8,

    /// The policy details for the `PutMultiRegionAccessPoint` request.
    policy: []const u8,
};
