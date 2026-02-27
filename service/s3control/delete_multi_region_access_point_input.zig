/// A container for the information associated with a
/// [DeleteMultiRegionAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteMultiRegionAccessPoint.html) request.
pub const DeleteMultiRegionAccessPointInput = struct {
    /// The name of the Multi-Region Access Point associated with this request.
    name: []const u8,
};
