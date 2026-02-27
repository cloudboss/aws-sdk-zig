/// Filter by the associated distribution ID or connection group ID.
pub const DistributionTenantAssociationFilter = struct {
    /// The ID of the connection group to filter by. You can find distribution
    /// tenants associated with a specific connection group.
    connection_group_id: ?[]const u8,

    /// The distribution ID to filter by. You can find distribution tenants
    /// associated with a specific distribution.
    distribution_id: ?[]const u8,
};
