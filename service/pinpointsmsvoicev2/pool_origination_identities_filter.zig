const PoolOriginationIdentitiesFilterName = @import("pool_origination_identities_filter_name.zig").PoolOriginationIdentitiesFilterName;

/// Information about origination identities associated with a pool that meets a
/// specified criteria.
pub const PoolOriginationIdentitiesFilter = struct {
    /// The name of the attribute to filter on.
    name: PoolOriginationIdentitiesFilterName,

    /// An array values to filter for.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
