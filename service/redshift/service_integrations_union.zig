const LakeFormationScopeUnion = @import("lake_formation_scope_union.zig").LakeFormationScopeUnion;
const RedshiftScopeUnion = @import("redshift_scope_union.zig").RedshiftScopeUnion;
const S3AccessGrantsScopeUnion = @import("s3_access_grants_scope_union.zig").S3AccessGrantsScopeUnion;

/// A list of service integrations.
pub const ServiceIntegrationsUnion = union(enum) {
    /// A list of scopes set up for Lake Formation integration.
    lake_formation: ?[]const LakeFormationScopeUnion,
    /// A list of scopes set up for Amazon Redshift integration.
    redshift: ?[]const RedshiftScopeUnion,
    /// A list of scopes set up for S3 Access Grants integration.
    s3_access_grants: ?[]const S3AccessGrantsScopeUnion,
};
