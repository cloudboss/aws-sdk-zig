const GlobalAuroraDefaultBehavior = @import("global_aurora_default_behavior.zig").GlobalAuroraDefaultBehavior;
const GlobalAuroraUngraceful = @import("global_aurora_ungraceful.zig").GlobalAuroraUngraceful;

/// Configuration for Amazon Aurora global databases used in a Region switch
/// plan.
pub const GlobalAuroraConfiguration = struct {
    /// The behavior for a global database, that is, only allow switchover or also
    /// allow failover.
    behavior: GlobalAuroraDefaultBehavior = "switchoverOnly",

    /// The cross account role for the configuration.
    cross_account_role: ?[]const u8 = null,

    /// The database cluster Amazon Resource Names (ARNs) for a global database.
    database_cluster_arns: []const []const u8,

    /// The external ID (secret key) for the configuration.
    external_id: ?[]const u8 = null,

    /// The global cluster identifier for a global database.
    global_cluster_identifier: []const u8,

    /// The timeout value specified for the configuration.
    timeout_minutes: i32 = 60,

    /// The settings for ungraceful execution.
    ungraceful: ?GlobalAuroraUngraceful = null,

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
