pub const NoSuchEntityErrorCode = enum {
    assessment_target_does_not_exist,
    assessment_template_does_not_exist,
    assessment_run_does_not_exist,
    finding_does_not_exist,
    resource_group_does_not_exist,
    rules_package_does_not_exist,
    sns_topic_does_not_exist,
    iam_role_does_not_exist,

    pub const json_field_names = .{
        .assessment_target_does_not_exist = "ASSESSMENT_TARGET_DOES_NOT_EXIST",
        .assessment_template_does_not_exist = "ASSESSMENT_TEMPLATE_DOES_NOT_EXIST",
        .assessment_run_does_not_exist = "ASSESSMENT_RUN_DOES_NOT_EXIST",
        .finding_does_not_exist = "FINDING_DOES_NOT_EXIST",
        .resource_group_does_not_exist = "RESOURCE_GROUP_DOES_NOT_EXIST",
        .rules_package_does_not_exist = "RULES_PACKAGE_DOES_NOT_EXIST",
        .sns_topic_does_not_exist = "SNS_TOPIC_DOES_NOT_EXIST",
        .iam_role_does_not_exist = "IAM_ROLE_DOES_NOT_EXIST",
    };
};
