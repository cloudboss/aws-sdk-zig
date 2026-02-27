const CvssScoreDetails = @import("cvss_score_details.zig").CvssScoreDetails;

/// Information about the factors that influenced the score that Amazon
/// Inspector assigned for a
/// finding.
pub const InspectorScoreDetails = struct {
    /// An object that contains details about an adjustment that Amazon Inspector
    /// made to the CVSS score
    /// for the finding.
    adjusted_cvss: ?CvssScoreDetails,

    pub const json_field_names = .{
        .adjusted_cvss = "adjustedCvss",
    };
};
