/// A summary of the latest analytics data for all your active assessments.
///
/// This summary is a snapshot of the data that your active assessments
/// collected on the
/// `lastUpdated` date. It’s important to understand that the following totals
/// are daily counts based on this date — they aren’t a total sum to date.
///
/// The `Insights` data is eventually consistent. This means that, when you read
/// data from `Insights`, the response might not instantly reflect the results
/// of a
/// recently completed write or update operation. If you repeat your read
/// request after a few
/// hours, the response should return the latest data.
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
pub const Insights = struct {
    /// The number of active assessments in Audit Manager.
    active_assessments_count: ?i32 = null,

    /// The number of assessment controls that collected non-compliant evidence on
    /// the
    /// `lastUpdated` date.
    assessment_controls_count_by_noncompliant_evidence: ?i32 = null,

    /// The number of compliance check evidence that Audit Manager classified as
    /// compliant
    /// on the `lastUpdated` date. This includes evidence that was collected from
    /// Security Hub with a *Pass* ruling, or collected from
    /// Config with a *Compliant* ruling.
    compliant_evidence_count: ?i32 = null,

    /// The number of evidence without a compliance check ruling. Evidence is
    /// inconclusive when
    /// the associated control uses Security Hub or Config as a data
    /// source but you didn't enable those services. This is also the case when a
    /// control uses a
    /// data source that doesn’t support compliance checks (for example: manual
    /// evidence, API
    /// calls, or CloudTrail).
    ///
    /// If evidence has a compliance check status of *not applicable*,
    /// it's classed as *inconclusive* in `Insights` data.
    inconclusive_evidence_count: ?i32 = null,

    /// The time when the cross-assessment insights were last updated.
    last_updated: ?i64 = null,

    /// The number of compliance check evidence that Audit Manager classified as
    /// non-compliant on the `lastUpdated` date. This includes evidence that was
    /// collected from Security Hub with a *Fail* ruling, or collected
    /// from Config with a *Non-compliant* ruling.
    noncompliant_evidence_count: ?i32 = null,

    /// The total number of controls across all active assessments.
    total_assessment_controls_count: ?i32 = null,

    pub const json_field_names = .{
        .active_assessments_count = "activeAssessmentsCount",
        .assessment_controls_count_by_noncompliant_evidence = "assessmentControlsCountByNoncompliantEvidence",
        .compliant_evidence_count = "compliantEvidenceCount",
        .inconclusive_evidence_count = "inconclusiveEvidenceCount",
        .last_updated = "lastUpdated",
        .noncompliant_evidence_count = "noncompliantEvidenceCount",
        .total_assessment_controls_count = "totalAssessmentControlsCount",
    };
};
