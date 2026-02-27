const aws = @import("aws");

const CategoryDetails = @import("category_details.zig").CategoryDetails;

/// Provides the category rules that are used to automatically categorize
/// contacts based
/// on uttered keywords and phrases.
pub const Categories = struct {
    /// The category rules that have been matched in the analyzed segment.
    matched_categories: []const []const u8,

    /// The category rule that was matched and when it occurred in the transcript.
    matched_details: []const aws.map.MapEntry(CategoryDetails),

    pub const json_field_names = .{
        .matched_categories = "MatchedCategories",
        .matched_details = "MatchedDetails",
    };
};
