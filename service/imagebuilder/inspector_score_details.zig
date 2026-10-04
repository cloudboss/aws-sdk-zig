const CvssScoreDetails = @import("cvss_score_details.zig").CvssScoreDetails;

/// Information about the factors that influenced the score that Amazon
/// Inspector assigned for a
/// finding.
pub const InspectorScoreDetails = struct {
    /// The CVSS score that Amazon Inspector assigned to the finding after applying
    /// its
    /// adjustments. It includes the score source, CVSS version, scoring vector,
    /// and the adjustments applied.
    adjusted_cvss: ?CvssScoreDetails = null,

    pub const json_field_names = .{
        .adjusted_cvss = "adjustedCvss",
    };
};
