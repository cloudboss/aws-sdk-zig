const std = @import("std");

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
        .aws_best_practices = "AWSBestPractices",
        .aws_cloudformation_issues = "AWSCloudFormationIssues",
        .duplicate_code = "DuplicateCode",
        .code_maintenance_issues = "CodeMaintenanceIssues",
        .concurrency_issues = "ConcurrencyIssues",
        .input_validations = "InputValidations",
        .python_best_practices = "PythonBestPractices",
        .java_best_practices = "JavaBestPractices",
        .resource_leaks = "ResourceLeaks",
        .security_issues = "SecurityIssues",
        .code_inconsistencies = "CodeInconsistencies",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .aws_best_practices => "AWSBestPractices",
            .aws_cloudformation_issues => "AWSCloudFormationIssues",
            .duplicate_code => "DuplicateCode",
            .code_maintenance_issues => "CodeMaintenanceIssues",
            .concurrency_issues => "ConcurrencyIssues",
            .input_validations => "InputValidations",
            .python_best_practices => "PythonBestPractices",
            .java_best_practices => "JavaBestPractices",
            .resource_leaks => "ResourceLeaks",
            .security_issues => "SecurityIssues",
            .code_inconsistencies => "CodeInconsistencies",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
