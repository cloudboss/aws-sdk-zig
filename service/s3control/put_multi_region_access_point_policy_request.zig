const PutMultiRegionAccessPointPolicyInput = @import("put_multi_region_access_point_policy_input.zig").PutMultiRegionAccessPointPolicyInput;

pub const PutMultiRegionAccessPointPolicyRequest = struct {
    /// The Amazon Web Services account ID for the owner of the Multi-Region Access
    /// Point.
    account_id: []const u8,

    /// An idempotency token used to identify the request and guarantee that
    /// requests are
    /// unique.
    client_token: []const u8,

    /// A container element containing the details of the policy for the
    /// Multi-Region Access Point.
    details: PutMultiRegionAccessPointPolicyInput,
};
