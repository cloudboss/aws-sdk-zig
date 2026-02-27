pub const SettingAttribute = enum {
    all,
    is_aws_org_enabled,
    sns_topic,
    default_assessment_reports_destination,
    default_process_owners,
    evidence_finder_enablement,
    deregistration_policy,
    default_export_destination,

    pub const json_field_names = .{
        .all = "ALL",
        .is_aws_org_enabled = "IS_AWS_ORG_ENABLED",
        .sns_topic = "SNS_TOPIC",
        .default_assessment_reports_destination = "DEFAULT_ASSESSMENT_REPORTS_DESTINATION",
        .default_process_owners = "DEFAULT_PROCESS_OWNERS",
        .evidence_finder_enablement = "EVIDENCE_FINDER_ENABLEMENT",
        .deregistration_policy = "DEREGISTRATION_POLICY",
        .default_export_destination = "DEFAULT_EXPORT_DESTINATION",
    };
};
