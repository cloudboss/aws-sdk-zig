const Behavior = @import("behavior.zig").Behavior;
const MetricValue = @import("metric_value.zig").MetricValue;
const VerificationState = @import("verification_state.zig").VerificationState;
const ViolationEventAdditionalInfo = @import("violation_event_additional_info.zig").ViolationEventAdditionalInfo;
const ViolationEventType = @import("violation_event_type.zig").ViolationEventType;

/// Information about a Device Defender security profile behavior violation.
pub const ViolationEvent = struct {
    /// The behavior that was violated.
    behavior: ?Behavior,

    /// The value of the metric (the measurement).
    metric_value: ?MetricValue,

    /// The name of the security profile whose behavior was violated.
    security_profile_name: ?[]const u8,

    /// The name of the thing responsible for the violation event.
    thing_name: ?[]const u8,

    /// The verification state of the violation (detect alarm).
    verification_state: ?VerificationState,

    /// The description of the verification state of the violation.
    verification_state_description: ?[]const u8,

    /// The details of a violation event.
    violation_event_additional_info: ?ViolationEventAdditionalInfo,

    /// The time the violation event occurred.
    violation_event_time: ?i64,

    /// The type of violation event.
    violation_event_type: ?ViolationEventType,

    /// The ID of the violation event.
    violation_id: ?[]const u8,

    pub const json_field_names = .{
        .behavior = "behavior",
        .metric_value = "metricValue",
        .security_profile_name = "securityProfileName",
        .thing_name = "thingName",
        .verification_state = "verificationState",
        .verification_state_description = "verificationStateDescription",
        .violation_event_additional_info = "violationEventAdditionalInfo",
        .violation_event_time = "violationEventTime",
        .violation_event_type = "violationEventType",
        .violation_id = "violationId",
    };
};
