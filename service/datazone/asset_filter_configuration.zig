const ColumnFilterConfiguration = @import("column_filter_configuration.zig").ColumnFilterConfiguration;
const RowFilterConfiguration = @import("row_filter_configuration.zig").RowFilterConfiguration;

/// The configuration details of the asset filter.
pub const AssetFilterConfiguration = union(enum) {
    /// The column configuration of the asset filter.
    column_configuration: ?ColumnFilterConfiguration,
    /// The row configuration of the asset filter.
    row_configuration: ?RowFilterConfiguration,

    pub const json_field_names = .{
        .column_configuration = "columnConfiguration",
        .row_configuration = "rowConfiguration",
    };
};
