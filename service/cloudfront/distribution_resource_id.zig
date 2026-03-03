/// The IDs for the distribution resources.
pub const DistributionResourceId = struct {
    /// The ID of the multi-tenant distribution.
    distribution_id: ?[]const u8 = null,

    /// The ID of the distribution tenant.
    distribution_tenant_id: ?[]const u8 = null,
};
