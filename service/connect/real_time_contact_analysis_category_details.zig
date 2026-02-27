const RealTimeContactAnalysisPointOfInterest = @import("real_time_contact_analysis_point_of_interest.zig").RealTimeContactAnalysisPointOfInterest;

/// Provides information about the category rule that was matched.
pub const RealTimeContactAnalysisCategoryDetails = struct {
    /// List of PointOfInterest - objects describing a single match of a rule.
    points_of_interest: []const RealTimeContactAnalysisPointOfInterest,

    pub const json_field_names = .{
        .points_of_interest = "PointsOfInterest",
    };
};
