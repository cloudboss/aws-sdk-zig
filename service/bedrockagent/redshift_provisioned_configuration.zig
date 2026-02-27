const RedshiftProvisionedAuthConfiguration = @import("redshift_provisioned_auth_configuration.zig").RedshiftProvisionedAuthConfiguration;

/// Contains configurations for a provisioned Amazon Redshift query engine.
pub const RedshiftProvisionedConfiguration = struct {
    /// Specifies configurations for authentication to Amazon Redshift.
    auth_configuration: RedshiftProvisionedAuthConfiguration,

    /// The ID of the Amazon Redshift cluster.
    cluster_identifier: []const u8,

    pub const json_field_names = .{
        .auth_configuration = "authConfiguration",
        .cluster_identifier = "clusterIdentifier",
    };
};
