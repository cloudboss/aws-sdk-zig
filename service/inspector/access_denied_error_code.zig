pub const AccessDeniedErrorCode = enum {
    access_denied_to_assessment_target,
    access_denied_to_assessment_template,
    access_denied_to_assessment_run,
    access_denied_to_finding,
    access_denied_to_resource_group,
    access_denied_to_rules_package,
    access_denied_to_sns_topic,
    access_denied_to_iam_role,

    pub const json_field_names = .{
        .access_denied_to_assessment_target = "ACCESS_DENIED_TO_ASSESSMENT_TARGET",
        .access_denied_to_assessment_template = "ACCESS_DENIED_TO_ASSESSMENT_TEMPLATE",
        .access_denied_to_assessment_run = "ACCESS_DENIED_TO_ASSESSMENT_RUN",
        .access_denied_to_finding = "ACCESS_DENIED_TO_FINDING",
        .access_denied_to_resource_group = "ACCESS_DENIED_TO_RESOURCE_GROUP",
        .access_denied_to_rules_package = "ACCESS_DENIED_TO_RULES_PACKAGE",
        .access_denied_to_sns_topic = "ACCESS_DENIED_TO_SNS_TOPIC",
        .access_denied_to_iam_role = "ACCESS_DENIED_TO_IAM_ROLE",
    };
};
