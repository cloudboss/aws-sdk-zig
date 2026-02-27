const FilterCircle = @import("filter_circle.zig").FilterCircle;

/// SearchText structure which contains a set of inclusion/exclusion properties
/// that results must possess in order to be returned as a result.
pub const SearchTextFilter = struct {
    /// The bounding box enclosing the geometric shape (area or line) that an
    /// individual result covers.
    ///
    /// The bounding box formed is defined as a set 4 coordinates: `[{westward lng},
    /// {southern lat}, {eastward lng}, {northern lat}]`
    bounding_box: ?[]const f64,

    circle: ?FilterCircle,

    /// A list of countries that all results must be in. Countries are represented
    /// by either their alpha-2 or alpha-3 character codes.
    include_countries: ?[]const []const u8,

    pub const json_field_names = .{
        .bounding_box = "BoundingBox",
        .circle = "Circle",
        .include_countries = "IncludeCountries",
    };
};
