/// Provides the details about the compliance status for a patch.
pub const AwsSsmComplianceSummary = struct {
    /// The type of resource for which the compliance was determined. For
    /// `AwsSsmPatchCompliance`, `ComplianceType` is `Patch`.
    compliance_type: ?[]const u8 = null,

    /// For the patches that are compliant, the number that have a severity of
    /// `CRITICAL`.
    compliant_critical_count: ?i32 = null,

    /// For the patches that are compliant, the number that have a severity of
    /// `HIGH`.
    compliant_high_count: ?i32 = null,

    /// For the patches that are compliant, the number that have a severity of
    /// `INFORMATIONAL`.
    compliant_informational_count: ?i32 = null,

    /// For the patches that are compliant, the number that have a severity of
    /// `LOW`.
    compliant_low_count: ?i32 = null,

    /// For the patches that are compliant, the number that have a severity of
    /// `MEDIUM`.
    compliant_medium_count: ?i32 = null,

    /// For the patches that are compliant, the number that have a severity of
    /// `UNSPECIFIED`.
    compliant_unspecified_count: ?i32 = null,

    /// The type of execution that was used determine compliance.
    execution_type: ?[]const u8 = null,

    /// For the patch items that are noncompliant, the number of items that have a
    /// severity of
    /// `CRITICAL`.
    non_compliant_critical_count: ?i32 = null,

    /// For the patches that are noncompliant, the number that have a severity of
    /// `HIGH`.
    non_compliant_high_count: ?i32 = null,

    /// For the patches that are noncompliant, the number that have a severity of
    /// `INFORMATIONAL`.
    non_compliant_informational_count: ?i32 = null,

    /// For the patches that are noncompliant, the number that have a severity of
    /// `LOW`.
    non_compliant_low_count: ?i32 = null,

    /// For the patches that are noncompliant, the number that have a severity of
    /// `MEDIUM`.
    non_compliant_medium_count: ?i32 = null,

    /// For the patches that are noncompliant, the number that have a severity of
    /// `UNSPECIFIED`.
    non_compliant_unspecified_count: ?i32 = null,

    /// The highest severity for the patches. Valid values are as follows:
    ///
    /// * `CRITICAL`
    ///
    /// * `HIGH`
    ///
    /// * `MEDIUM`
    ///
    /// * `LOW`
    ///
    /// * `INFORMATIONAL`
    ///
    /// * `UNSPECIFIED`
    overall_severity: ?[]const u8 = null,

    /// The identifier of the patch baseline. The patch baseline lists the patches
    /// that are
    /// approved for installation.
    patch_baseline_id: ?[]const u8 = null,

    /// The identifier of the patch group for which compliance was determined. A
    /// patch group
    /// uses tags to group EC2 instances that should have the same patch compliance.
    patch_group: ?[]const u8 = null,

    /// The current patch compliance status. Valid values are as follows:
    ///
    /// * `COMPLIANT`
    ///
    /// * `NON_COMPLIANT`
    ///
    /// * `UNSPECIFIED_DATA`
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .compliance_type = "ComplianceType",
        .compliant_critical_count = "CompliantCriticalCount",
        .compliant_high_count = "CompliantHighCount",
        .compliant_informational_count = "CompliantInformationalCount",
        .compliant_low_count = "CompliantLowCount",
        .compliant_medium_count = "CompliantMediumCount",
        .compliant_unspecified_count = "CompliantUnspecifiedCount",
        .execution_type = "ExecutionType",
        .non_compliant_critical_count = "NonCompliantCriticalCount",
        .non_compliant_high_count = "NonCompliantHighCount",
        .non_compliant_informational_count = "NonCompliantInformationalCount",
        .non_compliant_low_count = "NonCompliantLowCount",
        .non_compliant_medium_count = "NonCompliantMediumCount",
        .non_compliant_unspecified_count = "NonCompliantUnspecifiedCount",
        .overall_severity = "OverallSeverity",
        .patch_baseline_id = "PatchBaselineId",
        .patch_group = "PatchGroup",
        .status = "Status",
    };
};
