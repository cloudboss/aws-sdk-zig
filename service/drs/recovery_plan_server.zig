const RecoveryPlanServerImpactLevel = @import("recovery_plan_server_impact_level.zig").RecoveryPlanServerImpactLevel;

/// A server associated with a Recovery Plan Step.
pub const RecoveryPlanServer = struct {
    /// Defaults to CRITICAL if not specified.
    impact_level: ?RecoveryPlanServerImpactLevel = null,

    /// The ARN of the source server.
    server_arn: []const u8,

    pub const json_field_names = .{
        .impact_level = "impactLevel",
        .server_arn = "serverArn",
    };
};
