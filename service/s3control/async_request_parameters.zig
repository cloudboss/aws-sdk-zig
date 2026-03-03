const CreateMultiRegionAccessPointInput = @import("create_multi_region_access_point_input.zig").CreateMultiRegionAccessPointInput;
const DeleteMultiRegionAccessPointInput = @import("delete_multi_region_access_point_input.zig").DeleteMultiRegionAccessPointInput;
const PutMultiRegionAccessPointPolicyInput = @import("put_multi_region_access_point_policy_input.zig").PutMultiRegionAccessPointPolicyInput;

/// A container for the request parameters associated with an asynchronous
/// request.
pub const AsyncRequestParameters = struct {
    /// A container of the parameters for a
    /// [CreateMultiRegionAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_CreateMultiRegionAccessPoint.html) request.
    create_multi_region_access_point_request: ?CreateMultiRegionAccessPointInput = null,

    /// A container of the parameters for a
    /// [DeleteMultiRegionAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_DeleteMultiRegionAccessPoint.html) request.
    delete_multi_region_access_point_request: ?DeleteMultiRegionAccessPointInput = null,

    /// A container of the parameters for a
    /// [PutMultiRegionAccessPoint](https://docs.aws.amazon.com/AmazonS3/latest/API/API_control_PutMultiRegionAccessPoint.html) request.
    put_multi_region_access_point_policy_request: ?PutMultiRegionAccessPointPolicyInput = null,
};
