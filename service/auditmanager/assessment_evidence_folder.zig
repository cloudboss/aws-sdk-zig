/// The folder where Audit Manager stores evidence for an assessment.
pub const AssessmentEvidenceFolder = struct {
    /// The identifier for the assessment.
    assessment_id: ?[]const u8,

    /// The total count of evidence that's included in the assessment report.
    assessment_report_selection_count: i32 = 0,

    /// The name of the user who created the evidence folder.
    author: ?[]const u8,

    /// The unique identifier for the control.
    control_id: ?[]const u8,

    /// The name of the control.
    control_name: ?[]const u8,

    /// The identifier for the control set.
    control_set_id: ?[]const u8,

    /// The Amazon Web Services service that the evidence was collected from.
    data_source: ?[]const u8,

    /// The date when the first evidence was added to the evidence folder.
    date: ?i64,

    /// The total number of Amazon Web Services resources that were assessed to
    /// generate the
    /// evidence.
    evidence_aws_service_source_count: i32 = 0,

    /// The number of evidence that falls under the compliance check category. This
    /// evidence is
    /// collected from Config or Security Hub.
    evidence_by_type_compliance_check_count: i32 = 0,

    /// The total number of issues that were reported directly from Security Hub,
    /// Config, or both.
    evidence_by_type_compliance_check_issues_count: i32 = 0,

    /// The number of evidence that falls under the configuration data category.
    /// This evidence
    /// is collected from configuration snapshots of other Amazon Web Services
    /// services such as
    /// Amazon EC2, Amazon S3, or IAM.
    evidence_by_type_configuration_data_count: i32 = 0,

    /// The number of evidence that falls under the manual category. This evidence
    /// is imported
    /// manually.
    evidence_by_type_manual_count: i32 = 0,

    /// The number of evidence that falls under the user activity category. This
    /// evidence is
    /// collected from CloudTrail logs.
    evidence_by_type_user_activity_count: i32 = 0,

    /// The amount of evidence that's included in the evidence folder.
    evidence_resources_included_count: i32 = 0,

    /// The identifier for the folder that the evidence is stored in.
    id: ?[]const u8,

    /// The name of the evidence folder.
    name: ?[]const u8,

    /// The total amount of evidence in the evidence folder.
    total_evidence: i32 = 0,

    pub const json_field_names = .{
        .assessment_id = "assessmentId",
        .assessment_report_selection_count = "assessmentReportSelectionCount",
        .author = "author",
        .control_id = "controlId",
        .control_name = "controlName",
        .control_set_id = "controlSetId",
        .data_source = "dataSource",
        .date = "date",
        .evidence_aws_service_source_count = "evidenceAwsServiceSourceCount",
        .evidence_by_type_compliance_check_count = "evidenceByTypeComplianceCheckCount",
        .evidence_by_type_compliance_check_issues_count = "evidenceByTypeComplianceCheckIssuesCount",
        .evidence_by_type_configuration_data_count = "evidenceByTypeConfigurationDataCount",
        .evidence_by_type_manual_count = "evidenceByTypeManualCount",
        .evidence_by_type_user_activity_count = "evidenceByTypeUserActivityCount",
        .evidence_resources_included_count = "evidenceResourcesIncludedCount",
        .id = "id",
        .name = "name",
        .total_evidence = "totalEvidence",
    };
};
