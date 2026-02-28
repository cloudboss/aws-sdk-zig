const FilterDimension = @import("filter_dimension.zig").FilterDimension;
const Type = @import("type.zig").Type;

/// Object that holds the dimensions to filter on.
pub const FilterGroup = struct {
    /// Object that holds the attributes to filter on.
    dimensions: []const FilterDimension,

    /// The type of logical relationship between the dimensions of the Filter group.
    @"type": Type,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
        .@"type" = "Type",
    };
};
