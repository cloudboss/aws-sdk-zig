const ControlConditionType = @import("control_condition_type.zig").ControlConditionType;

/// A control condition is an alarm that you specify for a practice run. When
/// you configure practice runs with zonal autoshift for a resource, you specify
/// Amazon CloudWatch alarms, which you create in CloudWatch to use with the
/// practice run. The alarms that you specify are an *outcome alarm*, to monitor
/// application health during practice runs and, optionally, a *blocking alarm*,
/// to block practice runs from starting or to interrupt a practice run in
/// progress.
///
/// Control condition alarms do not apply for autoshifts.
///
/// For more information, see [ Considerations when you configure zonal
/// autoshift](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-autoshift.considerations.html) in the Amazon Application Recovery Controller Developer Guide.
pub const ControlCondition = struct {
    /// The Amazon Resource Name (ARN) for an Amazon CloudWatch alarm that you
    /// specify as a control condition for a practice run.
    alarm_identifier: []const u8,

    /// The type of alarm specified for a practice run. You can only specify Amazon
    /// CloudWatch alarms for practice runs, so the only valid value is
    /// `CLOUDWATCH`.
    @"type": ControlConditionType,

    pub const json_field_names = .{
        .alarm_identifier = "alarmIdentifier",
        .@"type" = "type",
    };
};
