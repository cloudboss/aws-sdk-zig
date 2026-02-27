pub const AutomatedReasoningPolicyBuildResultAssetType = enum {
    build_log,
    quality_report,
    policy_definition,
    generated_test_cases,
    policy_scenarios,

    pub const json_field_names = .{
        .build_log = "BUILD_LOG",
        .quality_report = "QUALITY_REPORT",
        .policy_definition = "POLICY_DEFINITION",
        .generated_test_cases = "GENERATED_TEST_CASES",
        .policy_scenarios = "POLICY_SCENARIOS",
    };
};
