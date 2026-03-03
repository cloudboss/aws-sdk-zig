const aws = @import("aws");

const AssociatedAlarm = @import("associated_alarm.zig").AssociatedAlarm;
const RecoveryApproach = @import("recovery_approach.zig").RecoveryApproach;
const ReportConfiguration = @import("report_configuration.zig").ReportConfiguration;
const Trigger = @import("trigger.zig").Trigger;
const Workflow = @import("workflow.zig").Workflow;

/// Represents a Region switch plan. A plan defines the steps required to shift
/// traffic from one Amazon Web Services Region to another.
pub const Plan = struct {
    /// The Amazon Resource Name (ARN) of the plan.
    arn: []const u8,

    /// The associated application health alarms for a plan.
    associated_alarms: ?[]const aws.map.MapEntry(AssociatedAlarm) = null,

    /// The description for a plan.
    description: ?[]const u8 = null,

    /// The execution role for a plan.
    execution_role: []const u8,

    /// The name for a plan.
    name: []const u8,

    /// The owner of a plan.
    owner: []const u8,

    /// The primary Region for a plan.
    primary_region: ?[]const u8 = null,

    /// The recovery approach for a Region switch plan, which can be active/active
    /// (activeActive) or active/passive (activePassive).
    recovery_approach: RecoveryApproach,

    /// The recovery time objective for a plan.
    recovery_time_objective_minutes: ?i32 = null,

    /// The Amazon Web Services Regions for a plan.
    regions: []const []const u8,

    /// The report configuration for a plan.
    report_configuration: ?ReportConfiguration = null,

    /// The triggers for a plan.
    triggers: ?[]const Trigger = null,

    /// The timestamp when the plan was last updated.
    updated_at: ?i64 = null,

    /// The version for the plan.
    version: ?[]const u8 = null,

    /// The workflows for a plan.
    workflows: []const Workflow,

    pub const json_field_names = .{
        .arn = "arn",
        .associated_alarms = "associatedAlarms",
        .description = "description",
        .execution_role = "executionRole",
        .name = "name",
        .owner = "owner",
        .primary_region = "primaryRegion",
        .recovery_approach = "recoveryApproach",
        .recovery_time_objective_minutes = "recoveryTimeObjectiveMinutes",
        .regions = "regions",
        .report_configuration = "reportConfiguration",
        .triggers = "triggers",
        .updated_at = "updatedAt",
        .version = "version",
        .workflows = "workflows",
    };
};
