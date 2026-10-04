const aws = @import("aws");

const NeptuneDefaultBehavior = @import("neptune_default_behavior.zig").NeptuneDefaultBehavior;
const NeptuneUngraceful = @import("neptune_ungraceful.zig").NeptuneUngraceful;

/// Configuration for Amazon Neptune global databases used in a Region switch
/// plan.
pub const NeptuneGlobalDatabaseConfiguration = struct {
    /// The behavior for a global database, that is, only allow switchover or also
    /// allow failover.
    behavior: NeptuneDefaultBehavior = .switchover_only,

    /// The cross account role for the configuration.
    cross_account_role: ?[]const u8 = null,

    /// The external ID (secret key) for the configuration.
    external_id: ?[]const u8 = null,

    /// The global cluster identifier for a Neptune global database.
    global_cluster_identifier: []const u8,

    /// The database cluster Amazon Resource Names (ARNs) for a Neptune global
    /// database.
    region_database_cluster_arns: []const aws.map.StringMapEntry,

    /// The timeout value specified for the configuration.
    timeout_minutes: i32 = 60,

    /// The settings for ungraceful execution.
    ungraceful: ?NeptuneUngraceful = null,

    pub const json_field_names = .{
        .behavior = "behavior",
        .cross_account_role = "crossAccountRole",
        .external_id = "externalId",
        .global_cluster_identifier = "globalClusterIdentifier",
        .region_database_cluster_arns = "regionDatabaseClusterArns",
        .timeout_minutes = "timeoutMinutes",
        .ungraceful = "ungraceful",
    };
};
