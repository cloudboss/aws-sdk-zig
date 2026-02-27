const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const InnerFilter = @import("inner_filter.zig").InnerFilter;

/// A `NestedFilter` filters data with a subset of data that is defined by the
/// nested inner filter.
pub const NestedFilter = struct {
    /// The column that the filter is applied to.
    column: ColumnIdentifier,

    /// An identifier that uniquely identifies a filter within a dashboard,
    /// analysis, or template.
    filter_id: []const u8,

    /// A boolean condition to include or exclude the subset that is defined by the
    /// values of the nested inner filter.
    include_inner_set: bool = false,

    /// The `InnerFilter` defines the subset of data to be used with the
    /// `NestedFilter`.
    inner_filter: InnerFilter,

    pub const json_field_names = .{
        .column = "Column",
        .filter_id = "FilterId",
        .include_inner_set = "IncludeInnerSet",
        .inner_filter = "InnerFilter",
    };
};
