const RelatedFinding = @import("related_finding.zig").RelatedFinding;
const FindingProviderSeverity = @import("finding_provider_severity.zig").FindingProviderSeverity;

/// In a [
/// `BatchImportFindings`
/// ](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_BatchImportFindings.html) request, finding providers use `FindingProviderFields` to provide
/// and update values for the following fields:
///
/// * `Confidence`
///
/// * `Criticality`
///
/// * `RelatedFindings`
///
/// * `Severity`
///
/// * `Types`
///
/// The preceding fields are nested under the `FindingProviderFields` object,
/// but also have analogues of the same name
/// as top-level ASFF fields. When a new finding is sent to Security Hub CSPM by
/// a finding provider, Security Hub CSPM populates the
/// `FindingProviderFields` object automatically, if it is empty, based on the
/// corresponding top-level fields.
///
/// Finding providers can update `FindingProviderFields` only by using the
/// `BatchImportFindings`
/// operation. Finding providers can't update
/// this object with the [
/// `BatchUpdateFindings`
/// ](https://docs.aws.amazon.com/securityhub/1.0/APIReference/API_BatchUpdateFindings.html) operation. Customers can update the top-level fields by using the `BatchUpdateFindings` operation. Customers can't
/// update `FindingProviderFields`.
///
/// For information about how Security Hub CSPM handles updates from
/// `BatchImportFindings` to
/// `FindingProviderFields` and to the corresponding top-level
/// attributes, see [Using `FindingProviderFields`
/// ](https://docs.aws.amazon.com/securityhub/latest/userguide/finding-update-batchimportfindings.html#batchimportfindings-findingproviderfields) in the *Security Hub CSPM User Guide*.
pub const FindingProviderFields = struct {
    /// A finding's confidence. Confidence is defined as the likelihood that a
    /// finding
    /// accurately identifies the behavior or issue that it was intended to
    /// identify.
    ///
    /// Confidence is scored on a 0-100 basis using a ratio scale, where 0 means
    /// zero percent
    /// confidence and 100 means 100 percent confidence.
    confidence: ?i32 = null,

    /// The level of importance assigned to the resources associated with the
    /// finding.
    ///
    /// A score of 0 means that the underlying resources have no criticality, and a
    /// score of 100
    /// is reserved for the most critical resources.
    criticality: ?i32 = null,

    /// A list of findings that are related to the current finding.
    related_findings: ?[]const RelatedFinding = null,

    /// The severity of a finding.
    severity: ?FindingProviderSeverity = null,

    /// One or more finding types in the format of `namespace/category/classifier`
    /// that classify a finding.
    ///
    /// Valid namespace values are: Software and Configuration Checks | TTPs |
    /// Effects | Unusual
    /// Behaviors | Sensitive Data Identifications
    types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .criticality = "Criticality",
        .related_findings = "RelatedFindings",
        .severity = "Severity",
        .types = "Types",
    };
};
