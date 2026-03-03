const ScalingAction = @import("scaling_action.zig").ScalingAction;
const ScalingTrigger = @import("scaling_trigger.zig").ScalingTrigger;

/// A scale-in or scale-out rule that defines scaling activity, including the
/// CloudWatch
/// metric alarm that triggers activity, how Amazon EC2 instances are added or
/// removed,
/// and the periodicity of adjustments. The automatic scaling policy for an
/// instance group can
/// comprise one or more automatic scaling rules.
pub const ScalingRule = struct {
    /// The conditions that trigger an automatic scaling activity.
    action: ScalingAction,

    /// A friendly, more verbose description of the automatic scaling rule.
    description: ?[]const u8 = null,

    /// The name used to identify an automatic scaling rule. Rule names must be
    /// unique within a
    /// scaling policy.
    name: []const u8,

    /// The CloudWatch alarm definition that determines when automatic scaling
    /// activity is
    /// triggered.
    trigger: ScalingTrigger,

    pub const json_field_names = .{
        .action = "Action",
        .description = "Description",
        .name = "Name",
        .trigger = "Trigger",
    };
};
