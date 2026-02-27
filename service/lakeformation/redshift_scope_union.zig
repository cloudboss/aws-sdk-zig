const RedshiftConnect = @import("redshift_connect.zig").RedshiftConnect;

/// A union structure representing different Redshift integration scopes.
pub const RedshiftScopeUnion = union(enum) {
    /// Configuration for Redshift Connect integration.
    redshift_connect: ?RedshiftConnect,

    pub const json_field_names = .{
        .redshift_connect = "RedshiftConnect",
    };
};
