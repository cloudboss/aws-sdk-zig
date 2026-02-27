/// Enumeration of the possible failure codes for instance onboarding job
pub const InstanceOnboardingJobFailureCode = enum {
    event_bridge_access_denied,
    event_bridge_managed_rule_limit_exceeded,
    iam_access_denied,
    kms_access_denied,
    kms_key_not_found,
    internal_failure,

    pub const json_field_names = .{
        .event_bridge_access_denied = "EVENT_BRIDGE_ACCESS_DENIED",
        .event_bridge_managed_rule_limit_exceeded = "EVENT_BRIDGE_MANAGED_RULE_LIMIT_EXCEEDED",
        .iam_access_denied = "IAM_ACCESS_DENIED",
        .kms_access_denied = "KMS_ACCESS_DENIED",
        .kms_key_not_found = "KMS_KEY_NOT_FOUND",
        .internal_failure = "INTERNAL_FAILURE",
    };
};
