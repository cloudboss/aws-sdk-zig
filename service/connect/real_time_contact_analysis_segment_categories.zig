const aws = @import("aws");

const RealTimeContactAnalysisCategoryDetails = @import("real_time_contact_analysis_category_details.zig").RealTimeContactAnalysisCategoryDetails;

/// The matched category rules.
pub const RealTimeContactAnalysisSegmentCategories = struct {
    /// Map between the name of the matched rule and
    /// RealTimeContactAnalysisCategoryDetails.
    matched_details: []const aws.map.MapEntry(RealTimeContactAnalysisCategoryDetails),

    pub const json_field_names = .{
        .matched_details = "MatchedDetails",
    };
};
