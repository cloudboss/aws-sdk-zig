const ExposureImpact = @import("exposure_impact.zig").ExposureImpact;
const ExposureSeverity = @import("exposure_severity.zig").ExposureSeverity;

/// Provides details about an exposure finding and the effect the specific
/// remediation target has on it.
pub const ExposureFinding = struct {
    /// The impact resolving a remediation target has on the exposure finding.
    ///
    /// * `Reduces` specifies that resolving the remediation target lowers the
    ///   severity of the exposure finding, but does not resolve it.
    ///
    /// * `Resolves` specifies that resolving the remediation target resolves the
    ///   exposure finding.
    ///
    /// * `Unchanged` specifies that resolving the remediation target does not
    ///   change the severity of the exposure finding.
    impact: ExposureImpact,

    /// The unique identifier (ID) of the Security Hub exposure finding, found under
    /// the
    /// `metadata.uid` field of the finding.
    metadata_uid: []const u8,

    /// The severity of the exposure finding before the remediation target is
    /// resolved.
    previous_severity: ExposureSeverity,

    /// The severity of the exposure finding after the remediation target is
    /// resolved.
    projected_severity: ExposureSeverity,

    /// The title of the exposure finding.
    title: []const u8,

    pub const json_field_names = .{
        .impact = "Impact",
        .metadata_uid = "MetadataUid",
        .previous_severity = "PreviousSeverity",
        .projected_severity = "ProjectedSeverity",
        .title = "Title",
    };
};
