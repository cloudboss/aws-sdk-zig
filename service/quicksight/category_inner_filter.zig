const ColumnIdentifier = @import("column_identifier.zig").ColumnIdentifier;
const CategoryFilterConfiguration = @import("category_filter_configuration.zig").CategoryFilterConfiguration;
const DefaultFilterControlConfiguration = @import("default_filter_control_configuration.zig").DefaultFilterControlConfiguration;

/// A `CategoryInnerFilter` filters text values for the `NestedFilter`.
pub const CategoryInnerFilter = struct {
    column: ColumnIdentifier,

    configuration: CategoryFilterConfiguration,

    default_filter_control_configuration: ?DefaultFilterControlConfiguration = null,

    pub const json_field_names = .{
        .column = "Column",
        .configuration = "Configuration",
        .default_filter_control_configuration = "DefaultFilterControlConfiguration",
    };
};
