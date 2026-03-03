/// A summary of the latest analytics data for a specific active assessment.
///
/// This summary is a snapshot of the data that was collected on the
/// `lastUpdated` date. It’s important to understand that the totals in
/// `InsightsByAssessment` are daily counts based on this date — they aren’t a
/// total sum to date.
///
/// The `InsightsByAssessment` data is eventually consistent. This means that
/// when you read data from `InsightsByAssessment`, the response might not
/// instantly
/// reflect the results of a recently completed write or update operation. If
/// you repeat your
/// read request after a few hours, the response returns the latest data.
///
/// If you delete an assessment or change its status to inactive,
/// `InsightsByAssessment` includes data for that assessment as
/// follows.
///
/// * **Inactive assessments** - If Audit Manager
/// collected evidence for your assessment before you changed it inactive, that
/// evidence is included in the `InsightsByAssessment` counts for that
/// day.
///
/// * **Deleted assessments** - If Audit Manager
/// collected evidence for your assessment before you deleted it, that evidence
/// isn't
/// included in the `InsightsByAssessment` counts for that day.
pub const InsightsByAssessment = struct {
    /// The number of assessment controls that collected non-compliant evidence on
    /// the
    /// `lastUpdated` date.
    assessment_controls_count_by_noncompliant_evidence: ?i32 = null,

    /// The number of compliance check evidence that Audit Manager classified as
    /// compliant.
    /// This includes evidence that was collected from Security Hub with a
    /// *Pass* ruling, or collected from Config with a
    /// *Compliant* ruling.
    compliant_evidence_count: ?i32 = null,

    /// The amount of evidence without a compliance check ruling. Evidence is
    /// inconclusive if
    /// the associated control uses Security Hub or Config as a data
    /// source and you didn't enable those services. This is also the case if a
    /// control uses a data
    /// source that doesn’t support compliance checks (for example, manual evidence,
    /// API calls, or
    /// CloudTrail).
    ///
    /// If evidence has a compliance check status of *not applicable*,
    /// it's classified as *inconclusive* in
    /// `InsightsByAssessment` data.
    inconclusive_evidence_count: ?i32 = null,

    /// The time when the assessment insights were last updated.
    last_updated: ?i64 = null,

    /// The number of compliance check evidence that Audit Manager classified as
    /// non-compliant. This includes evidence that was collected from Security Hub
    /// with a
    /// *Fail* ruling, or collected from Config with a
    /// *Non-compliant* ruling.
    noncompliant_evidence_count: ?i32 = null,

    /// The total number of controls in the assessment.
    total_assessment_controls_count: ?i32 = null,

    pub const json_field_names = .{
        .assessment_controls_count_by_noncompliant_evidence = "assessmentControlsCountByNoncompliantEvidence",
        .compliant_evidence_count = "compliantEvidenceCount",
        .inconclusive_evidence_count = "inconclusiveEvidenceCount",
        .last_updated = "lastUpdated",
        .noncompliant_evidence_count = "noncompliantEvidenceCount",
        .total_assessment_controls_count = "totalAssessmentControlsCount",
    };
};
