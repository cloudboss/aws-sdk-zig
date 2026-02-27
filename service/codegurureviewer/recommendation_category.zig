pub const RecommendationCategory = enum {
    aws_best_practices,
    aws_cloudformation_issues,
    duplicate_code,
    code_maintenance_issues,
    concurrency_issues,
    input_validations,
    python_best_practices,
    java_best_practices,
    resource_leaks,
    security_issues,
    code_inconsistencies,

    pub const json_field_names = .{
        .aws_best_practices = "AWS_BEST_PRACTICES",
        .aws_cloudformation_issues = "AWS_CLOUDFORMATION_ISSUES",
        .duplicate_code = "DUPLICATE_CODE",
        .code_maintenance_issues = "CODE_MAINTENANCE_ISSUES",
        .concurrency_issues = "CONCURRENCY_ISSUES",
        .input_validations = "INPUT_VALIDATIONS",
        .python_best_practices = "PYTHON_BEST_PRACTICES",
        .java_best_practices = "JAVA_BEST_PRACTICES",
        .resource_leaks = "RESOURCE_LEAKS",
        .security_issues = "SECURITY_ISSUES",
        .code_inconsistencies = "CODE_INCONSISTENCIES",
    };
};
