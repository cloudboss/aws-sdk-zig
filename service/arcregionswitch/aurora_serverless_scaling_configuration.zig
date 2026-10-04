const aws = @import("aws");

/// Configuration for Amazon Aurora Serverless scaling used in a Region switch
/// plan.
pub const AuroraServerlessScalingConfiguration = struct {
    /// The cross account role for the configuration.
    cross_account_role: ?[]const u8 = null,

    /// The external ID (secret key) for the configuration.
    external_id: ?[]const u8 = null,

    /// The global cluster identifier for a global database.
    global_cluster_identifier: []const u8,

    /// Per-Region configuration that maps each Region to the Aurora database
    /// cluster ARN for scaling.
    region_database_cluster_arns: []const aws.map.StringMapEntry,

    /// The target capacity percentage for Aurora Serverless scaling.
    target_percent: i32 = 100,

    /// The timeout value specified for the configuration.
    timeout_minutes: i32 = 60,

    pub const json_field_names = .{
        .cross_account_role = "crossAccountRole",
        .external_id = "externalId",
        .global_cluster_identifier = "globalClusterIdentifier",
        .region_database_cluster_arns = "regionDatabaseClusterArns",
        .target_percent = "targetPercent",
        .timeout_minutes = "timeoutMinutes",
    };
};
