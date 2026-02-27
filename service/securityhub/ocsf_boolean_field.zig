pub const OcsfBooleanField = enum {
    compliance_assessments_meets_criteria,
    vulnerabilities_is_exploit_available,
    vulnerabilities_is_fix_available,

    pub const json_field_names = .{
        .compliance_assessments_meets_criteria = "COMPLIANCE_ASSESSMENTS_MEETS_CRITERIA",
        .vulnerabilities_is_exploit_available = "VULNERABILITIES_IS_EXPLOIT_AVAILABLE",
        .vulnerabilities_is_fix_available = "VULNERABILITIES_IS_FIX_AVAILABLE",
    };
};
