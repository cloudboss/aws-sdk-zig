/// Provides the details of the `StartTimer` decision.
///
/// **Access Control**
///
/// You can use IAM policies to control this decision's access to Amazon SWF
/// resources as follows:
///
/// * Use a `Resource` element with the domain name to limit the action to only
/// specified domains.
///
/// * Use an `Action` element to allow or deny permission to call this action.
///
/// * You cannot use an IAM policy to constrain this action's parameters.
///
/// If the caller doesn't have sufficient permissions to invoke the action, or
/// the
/// parameter values fall outside the specified constraints, the action fails.
/// The associated event attribute's
/// `cause` parameter is set to `OPERATION_NOT_PERMITTED`. For details and
/// example IAM policies, see
/// [Using IAM to Manage Access to Amazon SWF
/// Workflows](https://docs.aws.amazon.com/amazonswf/latest/developerguide/swf-dev-iam.html) in the *Amazon SWF Developer Guide*.
pub const StartTimerDecisionAttributes = struct {
    /// The data attached to the event that can be used by the decider in subsequent
    /// workflow tasks.
    control: ?[]const u8,

    /// The duration to wait before firing the timer.
    ///
    /// The duration is specified in seconds, an integer greater than or equal to
    /// `0`.
    start_to_fire_timeout: []const u8,

    /// The unique ID of the timer.
    ///
    /// The specified string must not contain a
    /// `:` (colon), `/` (slash), `|` (vertical bar), or any
    /// control characters (`\u0000-\u001f` | `\u007f-\u009f`). Also, it must
    /// *not* be the literal string `arn`.
    timer_id: []const u8,

    pub const json_field_names = .{
        .control = "control",
        .start_to_fire_timeout = "startToFireTimeout",
        .timer_id = "timerId",
    };
};
