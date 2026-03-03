const aws = @import("aws");

const PointsOfInterest = @import("points_of_interest.zig").PointsOfInterest;

/// Provides information on any `TranscriptFilterType` categories that matched
/// your
/// transcription output. Matches are identified for each segment upon
/// completion of that segment.
pub const CategoryEvent = struct {
    /// Lists the categories that were matched in your audio segment.
    matched_categories: ?[]const []const u8 = null,

    /// Contains information about the matched categories, including category names
    /// and timestamps.
    matched_details: ?[]const aws.map.MapEntry(PointsOfInterest) = null,

    pub const json_field_names = .{
        .matched_categories = "MatchedCategories",
        .matched_details = "MatchedDetails",
    };
};
