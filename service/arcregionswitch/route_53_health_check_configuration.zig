const Route53ResourceRecordSet = @import("route_53_resource_record_set.zig").Route53ResourceRecordSet;

/// The Amazon Route 53 health check configuration.
pub const Route53HealthCheckConfiguration = struct {
    /// The cross account role for the configuration.
    cross_account_role: ?[]const u8 = null,

    /// The external ID (secret key) for the configuration.
    external_id: ?[]const u8 = null,

    /// The Amazon Route 53 health check configuration hosted zone ID.
    hosted_zone_id: []const u8,

    /// The Amazon Route 53 health check configuration record name.
    record_name: []const u8,

    /// The Amazon Route 53 health check configuration record sets.
    record_sets: ?[]const Route53ResourceRecordSet = null,

    /// The Amazon Route 53 health check configuration time out (in minutes).
    timeout_minutes: i32 = 60,

    pub const json_field_names = .{
        .cross_account_role = "crossAccountRole",
        .external_id = "externalId",
        .hosted_zone_id = "hostedZoneId",
        .record_name = "recordName",
        .record_sets = "recordSets",
        .timeout_minutes = "timeoutMinutes",
    };
};
