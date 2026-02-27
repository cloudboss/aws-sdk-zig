/// Contains information about the effect that Organizations has on a policy
/// simulation.
pub const OrganizationsDecisionDetail = struct {
    /// Specifies whether the simulated operation is allowed by the Organizations
    /// service control
    /// policies that impact the simulated user's account.
    allowed_by_organizations: bool = false,
};
