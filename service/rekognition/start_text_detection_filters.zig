const RegionOfInterest = @import("region_of_interest.zig").RegionOfInterest;
const DetectionFilter = @import("detection_filter.zig").DetectionFilter;

/// Set of optional parameters that let you set the criteria text must meet to
/// be included in your response.
/// `WordFilter` looks at a word's height, width and minimum confidence.
/// `RegionOfInterest`
/// lets you set a specific region of the screen to look for text in.
pub const StartTextDetectionFilters = struct {
    /// Filter focusing on a certain area of the frame. Uses a `BoundingBox` object
    /// to set the region
    /// of the screen.
    regions_of_interest: ?[]const RegionOfInterest,

    /// Filters focusing on qualities of the text, such as confidence or size.
    word_filter: ?DetectionFilter,

    pub const json_field_names = .{
        .regions_of_interest = "RegionsOfInterest",
        .word_filter = "WordFilter",
    };
};
