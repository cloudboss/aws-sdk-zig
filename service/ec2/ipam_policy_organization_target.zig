/// The Amazon Web Services Organizations target for an IPAM policy.
pub const IpamPolicyOrganizationTarget = struct {
    /// The ID of the Amazon Web Services Organizations target.
    ///
    /// A target can be an individual Amazon Web Services account or an entity
    /// within an Amazon Web Services Organization to which an IPAM policy can be
    /// applied.
    organization_target_id: ?[]const u8,
};
