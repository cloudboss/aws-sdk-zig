const FieldSortOptions = @import("field_sort_options.zig").FieldSortOptions;

/// The sort configuration of a KPI visual.
pub const KPISortConfiguration = struct {
    /// The sort configuration of the trend group fields.
    trend_group_sort: ?[]const FieldSortOptions,

    pub const json_field_names = .{
        .trend_group_sort = "TrendGroupSort",
    };
};
