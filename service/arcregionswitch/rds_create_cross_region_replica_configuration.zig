const aws = @import("aws");

/// Configuration for creating an Amazon RDS cross-Region read replica during
/// post-recovery in a Region switch.
pub const RdsCreateCrossRegionReplicaConfiguration = struct {
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
