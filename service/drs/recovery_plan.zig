const aws = @import("aws");

const RecoveryPlanStatus = @import("recovery_plan_status.zig").RecoveryPlanStatus;

/// A Recovery Plan resource.
pub const RecoveryPlan = struct {
    /// The timestamp when the Recovery Plan was created.
    created_at: []const u8,

    description: ?[]const u8 = null,

    name: []const u8,

    /// The ARN of the Recovery Plan.
    recovery_plan_arn: []const u8,

    /// The status of the Recovery Plan.
    status: RecoveryPlanStatus,

    /// The tags associated with the Recovery Plan.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp when the Recovery Plan was last updated.
    updated_at: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .name = "name",
        .recovery_plan_arn = "recoveryPlanArn",
        .status = "status",
        .tags = "tags",
        .updated_at = "updatedAt",
    };
};
