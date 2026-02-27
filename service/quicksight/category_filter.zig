const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const CategoryFilterConfiguration = @import("category_filter_configuration.zig").CategoryFilterConfiguration;
const DefaultFilterControlConfiguration = @import("default_filter_control_configuration.zig").DefaultFilterControlConfiguration;

/// A `CategoryFilter` filters text values.
///
/// For more information, see [Adding text
/// filters](https://docs.aws.amazon.com/quicksight/latest/user/add-a-text-filter-data-prep.html) in the *Amazon Quick Suite User Guide*.
pub const CategoryFilter = struct {
    /// The column that the filter is applied to.
    column: ColumnIdentifier,

    /// The configuration for a `CategoryFilter`.
    configuration: CategoryFilterConfiguration,

    /// The default configurations for the associated controls. This applies only
    /// for filters that are scoped to multiple sheets.
    default_filter_control_configuration: ?DefaultFilterControlConfiguration,

    /// An identifier that uniquely identifies a filter within a dashboard,
    /// analysis, or template.
    filter_id: []const u8,

    pub const json_field_names = .{
        .column = "Column",
        .configuration = "Configuration",
        .default_filter_control_configuration = "DefaultFilterControlConfiguration",
        .filter_id = "FilterId",
    };
};
