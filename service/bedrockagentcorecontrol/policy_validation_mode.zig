pub const PolicyValidationMode = enum {
    fail_on_any_findings,
    ignore_all_findings,

    pub const json_field_names = .{
        .fail_on_any_findings = "FAIL_ON_ANY_FINDINGS",
        .ignore_all_findings = "IGNORE_ALL_FINDINGS",
    };
};
