const SortAttribute = @import("sort_attribute.zig").SortAttribute;

/// Defines how segments should be sorted and ordered in the results.
pub const SegmentSort = struct {
    /// A list of attributes used to sort the segments and their ordering
    /// preferences.
    attributes: []const SortAttribute,

    pub const json_field_names = .{
        .attributes = "Attributes",
    };
};
