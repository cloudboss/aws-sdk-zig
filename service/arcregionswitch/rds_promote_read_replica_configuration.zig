const aws = @import("aws");

/// Configuration for promoting an Amazon RDS read replica to a standalone
/// database instance during a Region switch.
pub const RdsPromoteReadReplicaConfiguration = struct {
    /// The cross-account role for the configuration.
    cross_account_role: ?[]const u8 = null,

    /// A map of database instance ARNs for each Region in the plan.
    db_instance_arn_map: []const aws.map.StringMapEntry,

    /// The external ID (secret key) for the configuration.
    external_id: ?[]const u8 = null,

    /// The timeout value specified for the configuration.
    timeout_minutes: i32 = 60,

    pub const json_field_names = .{
        .cross_account_role = "crossAccountRole",
        .db_instance_arn_map = "dbInstanceArnMap",
        .external_id = "externalId",
        .timeout_minutes = "timeoutMinutes",
    };
};
