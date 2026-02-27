const RedshiftScopeUnion = @import("redshift_scope_union.zig").RedshiftScopeUnion;

/// A union structure representing different service integration types.
pub const ServiceIntegrationUnion = union(enum) {
    /// Redshift service integration configuration.
    redshift: ?[]const RedshiftScopeUnion,

    pub const json_field_names = .{
        .redshift = "Redshift",
    };
};
