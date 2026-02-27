pub const AppComplianceStatusType = enum {
    policy_breached,
    policy_met,
    not_assessed,
    changes_detected,
    not_applicable,
    missing_policy,

    pub const json_field_names = .{
        .policy_breached = "POLICY_BREACHED",
        .policy_met = "POLICY_MET",
        .not_assessed = "NOT_ASSESSED",
        .changes_detected = "CHANGES_DETECTED",
        .not_applicable = "NOT_APPLICABLE",
        .missing_policy = "MISSING_POLICY",
    };
};
