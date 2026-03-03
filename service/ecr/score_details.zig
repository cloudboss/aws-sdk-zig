const CvssScoreDetails = @import("cvss_score_details.zig").CvssScoreDetails;

/// Information about the Amazon Inspector score given to a finding.
pub const ScoreDetails = struct {
    /// An object that contains details about the CVSS score given to a finding.
    cvss: ?CvssScoreDetails = null,

    pub const json_field_names = .{
        .cvss = "cvss",
    };
};
