const RecoveryApproach = @import("recovery_approach.zig").RecoveryApproach;

/// A summarized representation of a Region switch plan. This structure contains
/// key information about a plan without all the detailed workflow and step
/// data.
pub const AbbreviatedPlan = struct {
    /// Specifies if this is the active plan execution at this time.
    active_plan_execution: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Region switch plan.
    arn: []const u8,

    /// The description of a Region switch plan.
    description: ?[]const u8 = null,

    /// The execution role is a way to categorize a Region switch plan.
    execution_role: ?[]const u8 = null,

    /// The name of a Region switch plan.
    name: []const u8,

    /// The owner of a Region switch plan.
    owner: []const u8,

    /// The primary Region for a plan.
    primary_region: ?[]const u8 = null,

    /// The recovery approach for a Region switch plan, which can be active/active
    /// (activeActive) or active/passive (activePassive).
    recovery_approach: RecoveryApproach,

    /// The recovery time objective that you've specified.
    recovery_time_objective_minutes: ?i32 = null,

    /// The Amazon Web Services Region specified for a Region switch plan.
    regions: []const []const u8,

    /// The timestamp when the plan execution was last updated.
    updated_at: ?i64 = null,

    /// The version for the plan.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .active_plan_execution = "activePlanExecution",
        .arn = "arn",
        .description = "description",
        .execution_role = "executionRole",
        .name = "name",
        .owner = "owner",
        .primary_region = "primaryRegion",
        .recovery_approach = "recoveryApproach",
        .recovery_time_objective_minutes = "recoveryTimeObjectiveMinutes",
        .regions = "regions",
        .updated_at = "updatedAt",
        .version = "version",
    };
};
