/// The proposed access control policy for the Multi-Region Access Point.
///
/// When you update the policy, the update is first listed as the proposed
/// policy. After the
/// update is finished and all Regions have been updated, the proposed policy is
/// listed as the
/// established policy. If both policies have the same version number, the
/// proposed policy is
/// the established policy.
pub const ProposedMultiRegionAccessPointPolicy = struct {
    /// The details of the proposed policy.
    policy: ?[]const u8 = null,
};
