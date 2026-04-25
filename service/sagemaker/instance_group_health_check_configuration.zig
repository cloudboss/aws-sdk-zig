const DeepHealthCheckType = @import("deep_health_check_type.zig").DeepHealthCheckType;

/// The configuration of deep health checks for an instance group.
///
/// Overlapping deep health check configurations will be merged into a single
/// operation.
pub const InstanceGroupHealthCheckConfiguration = struct {
    /// A list of deep health checks to be performed.
    deep_health_checks: []const DeepHealthCheckType,

    /// The name of the instance group.
    instance_group_name: []const u8,

    /// A list of Amazon Elastic Compute Cloud (EC2) instance IDs on which to
    /// perform deep health checks.
    ///
    /// Leave this field blank to perform deep health checks on the entire instance
    /// group.
    instance_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .deep_health_checks = "DeepHealthChecks",
        .instance_group_name = "InstanceGroupName",
        .instance_ids = "InstanceIds",
    };
};
