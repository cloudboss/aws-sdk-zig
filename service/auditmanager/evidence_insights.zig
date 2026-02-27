/// A breakdown of the latest compliance check status for the evidence in your
/// Audit Manager assessments.
pub const EvidenceInsights = struct {
    /// The number of compliance check evidence that Audit Manager classified as
    /// compliant.
    /// This includes evidence that was collected from Security Hub with a
    /// *Pass* ruling, or collected from Config with a
    /// *Compliant* ruling.
    compliant_evidence_count: ?i32,

    /// The number of evidence that a compliance check ruling isn't available for.
    /// Evidence is
    /// inconclusive when the associated control uses Security Hub or Config as a
    /// data source but you didn't enable those services. This is also the case when
    /// a
    /// control uses a data source that doesn’t support compliance checks (for
    /// example, manual
    /// evidence, API calls, or CloudTrail).
    ///
    /// If evidence has a compliance check status of *not applicable* in
    /// the console, it's classified as *inconclusive* in
    /// `EvidenceInsights` data.
    inconclusive_evidence_count: ?i32,

    /// The number of compliance check evidence that Audit Manager classified as
    /// non-compliant. This includes evidence that was collected from Security Hub
    /// with a
    /// *Fail* ruling, or collected from Config with a
    /// *Non-compliant* ruling.
    noncompliant_evidence_count: ?i32,

    pub const json_field_names = .{
        .compliant_evidence_count = "compliantEvidenceCount",
        .inconclusive_evidence_count = "inconclusiveEvidenceCount",
        .noncompliant_evidence_count = "noncompliantEvidenceCount",
    };
};
