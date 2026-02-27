const LakeFormationQuery = @import("lake_formation_query.zig").LakeFormationQuery;

/// A list of scopes set up for Lake Formation integration.
pub const LakeFormationScopeUnion = union(enum) {
    /// The Lake Formation scope.
    lake_formation_query: ?LakeFormationQuery,
};
