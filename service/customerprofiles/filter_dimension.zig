const aws = @import("aws");

const FilterAttributeDimension = @import("filter_attribute_dimension.zig").FilterAttributeDimension;

/// Contains the map of attribute names to attribute dimensions.
pub const FilterDimension = struct {
    /// Is the attribute within the FilterDimension map
    attributes: []const aws.map.MapEntry(FilterAttributeDimension),

    pub const json_field_names = .{
        .attributes = "Attributes",
    };
};
