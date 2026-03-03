const EstablishedMultiRegionAccessPointPolicy = @import("established_multi_region_access_point_policy.zig").EstablishedMultiRegionAccessPointPolicy;
const ProposedMultiRegionAccessPointPolicy = @import("proposed_multi_region_access_point_policy.zig").ProposedMultiRegionAccessPointPolicy;

/// The Multi-Region Access Point access control policy.
///
/// When you update the policy, the update is first listed as the proposed
/// policy. After the
/// update is finished and all Regions have been updated, the proposed policy is
/// listed as the
/// established policy. If both policies have the same version number, the
/// proposed policy is
/// the established policy.
pub const MultiRegionAccessPointPolicyDocument = struct {
    /// The last established policy for the Multi-Region Access Point.
    established: ?EstablishedMultiRegionAccessPointPolicy = null,

    /// The proposed policy for the Multi-Region Access Point.
    proposed: ?ProposedMultiRegionAccessPointPolicy = null,
};
