/// The stop CIS message progress.
pub const StopCisMessageProgress = struct {
    /// The progress' error checks.
    error_checks: i32 = 0,

    /// The progress' failed checks.
    failed_checks: i32 = 0,

    /// The progress' informational checks.
    informational_checks: i32 = 0,

    /// The progress' not applicable checks.
    not_applicable_checks: i32 = 0,

    /// The progress' not evaluated checks.
    not_evaluated_checks: i32 = 0,

    /// The progress' successful checks.
    successful_checks: i32 = 0,

    /// The progress' total checks.
    total_checks: i32 = 0,

    /// The progress' unknown checks.
    unknown_checks: i32 = 0,

    pub const json_field_names = .{
        .error_checks = "errorChecks",
        .failed_checks = "failedChecks",
        .informational_checks = "informationalChecks",
        .not_applicable_checks = "notApplicableChecks",
        .not_evaluated_checks = "notEvaluatedChecks",
        .successful_checks = "successfulChecks",
        .total_checks = "totalChecks",
        .unknown_checks = "unknownChecks",
    };
};
