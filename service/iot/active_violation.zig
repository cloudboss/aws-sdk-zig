const Behavior = @import("behavior.zig").Behavior;
const MetricValue = @import("metric_value.zig").MetricValue;
const VerificationState = @import("verification_state.zig").VerificationState;
const ViolationEventAdditionalInfo = @import("violation_event_additional_info.zig").ViolationEventAdditionalInfo;

/// Information about an active Device Defender security profile behavior
/// violation.
pub const ActiveViolation = struct {
    /// The behavior that is being violated.
    behavior: ?Behavior = null,

    /// The time the most recent violation occurred.
    last_violation_time: ?i64 = null,

    /// The value of the metric (the measurement) that caused the most recent
    /// violation.
    last_violation_value: ?MetricValue = null,

    /// The security profile with the behavior is in violation.
    security_profile_name: ?[]const u8 = null,

    /// The name of the thing responsible for the active violation.
    thing_name: ?[]const u8 = null,

    /// The verification state of the violation (detect alarm).
    verification_state: ?VerificationState = null,

    /// The description of the verification state of the violation.
    verification_state_description: ?[]const u8 = null,

    /// The details of a violation event.
    violation_event_additional_info: ?ViolationEventAdditionalInfo = null,

    /// The ID of the active violation.
    violation_id: ?[]const u8 = null,

    /// The time the violation started.
    violation_start_time: ?i64 = null,

    pub const json_field_names = .{
        .behavior = "behavior",
        .last_violation_time = "lastViolationTime",
        .last_violation_value = "lastViolationValue",
        .security_profile_name = "securityProfileName",
        .thing_name = "thingName",
        .verification_state = "verificationState",
        .verification_state_description = "verificationStateDescription",
        .violation_event_additional_info = "violationEventAdditionalInfo",
        .violation_id = "violationId",
        .violation_start_time = "violationStartTime",
    };
};
