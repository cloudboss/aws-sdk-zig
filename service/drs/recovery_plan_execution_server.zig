const RecoveryPlanServerImpactLevel = @import("recovery_plan_server_impact_level.zig").RecoveryPlanServerImpactLevel;

/// A server within a recovery plan execution step, enriched with execution
/// state.
pub const RecoveryPlanExecutionServer = struct {
    /// Defaults to CRITICAL if not specified.
    impact_level: ?RecoveryPlanServerImpactLevel = null,

    /// The DRS recovery job ID. Populated when recovery is initiated for this
    /// server.
    job_id: ?[]const u8 = null,

    /// The ARN of the source server.
    server_arn: []const u8,

    pub const json_field_names = .{
        .impact_level = "impactLevel",
        .job_id = "jobID",
        .server_arn = "serverArn",
    };
};
