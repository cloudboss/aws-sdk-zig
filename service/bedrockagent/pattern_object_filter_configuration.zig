const PatternObjectFilter = @import("pattern_object_filter.zig").PatternObjectFilter;

/// The configuration of filtering certain objects or content types of the data
/// source.
pub const PatternObjectFilterConfiguration = struct {
    /// The configuration of specific filters applied to your data source content.
    /// You can filter out or include certain content.
    filters: []const PatternObjectFilter,

    pub const json_field_names = .{
        .filters = "filters",
    };
};
