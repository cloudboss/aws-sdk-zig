const DocumentDbDefaultBehavior = @import("document_db_default_behavior.zig").DocumentDbDefaultBehavior;
const DocumentDbUngraceful = @import("document_db_ungraceful.zig").DocumentDbUngraceful;

/// Configuration for Amazon DocumentDB global clusters used in a Region switch
/// plan.
pub const DocumentDbConfiguration = struct {
    /// The behavior for a global cluster, that is, only allow switchover or also
    /// allow failover.
    behavior: DocumentDbDefaultBehavior = .switchover_only,

    /// The cross account role for the configuration.
    cross_account_role: ?[]const u8 = null,

    /// The database cluster Amazon Resource Names (ARNs) for a DocumentDB global
    /// cluster.
    database_cluster_arns: []const []const u8,

    /// The external ID (secret key) for the configuration.
    external_id: ?[]const u8 = null,

    /// The global cluster identifier for a DocumentDB global cluster.
    global_cluster_identifier: []const u8,

    /// The timeout value specified for the configuration.
    timeout_minutes: i32 = 60,

    /// The settings for ungraceful execution.
    ungraceful: ?DocumentDbUngraceful = null,

    pub const json_field_names = .{
        .behavior = "behavior",
        .cross_account_role = "crossAccountRole",
        .database_cluster_arns = "databaseClusterArns",
        .external_id = "externalId",
        .global_cluster_identifier = "globalClusterIdentifier",
        .timeout_minutes = "timeoutMinutes",
        .ungraceful = "ungraceful",
    };
};
