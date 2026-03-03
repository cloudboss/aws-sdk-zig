const RegionOfInterest = @import("region_of_interest.zig").RegionOfInterest;
const DetectionFilter = @import("detection_filter.zig").DetectionFilter;

/// A set of optional parameters that you can use to set the criteria that the
/// text must meet
/// to be included in your response. `WordFilter` looks at a word’s height,
/// width, and
/// minimum confidence. `RegionOfInterest` lets you set a specific region of the
/// image
/// to look for text in.
pub const DetectTextFilters = struct {
    /// A Filter focusing on a certain area of the image. Uses a `BoundingBox`
    /// object
    /// to set the region of the image.
    regions_of_interest: ?[]const RegionOfInterest = null,

    word_filter: ?DetectionFilter = null,

    pub const json_field_names = .{
        .regions_of_interest = "RegionsOfInterest",
        .word_filter = "WordFilter",
    };
};
