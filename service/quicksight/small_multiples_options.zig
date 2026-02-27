const PanelConfiguration = @import("panel_configuration.zig").PanelConfiguration;
const SmallMultiplesAxisProperties = @import("small_multiples_axis_properties.zig").SmallMultiplesAxisProperties;

/// Options that determine the layout and display options of a chart's small
/// multiples.
pub const SmallMultiplesOptions = struct {
    /// Sets the maximum number of visible columns to display in the grid of small
    /// multiples panels.
    ///
    /// The default is `Auto`, which automatically adjusts the columns in the grid
    /// to fit the overall layout and size of the given chart.
    max_visible_columns: ?i64,

    /// Sets the maximum number of visible rows to display in the grid of small
    /// multiples panels.
    ///
    /// The default value is `Auto`,
    /// which automatically adjusts the rows in the grid
    /// to fit the overall layout and size of the given chart.
    max_visible_rows: ?i64,

    /// Configures the display options for each small multiples panel.
    panel_configuration: ?PanelConfiguration,

    /// The properties of a small multiples X axis.
    x_axis: ?SmallMultiplesAxisProperties,

    /// The properties of a small multiples Y axis.
    y_axis: ?SmallMultiplesAxisProperties,

    pub const json_field_names = .{
        .max_visible_columns = "MaxVisibleColumns",
        .max_visible_rows = "MaxVisibleRows",
        .panel_configuration = "PanelConfiguration",
        .x_axis = "XAxis",
        .y_axis = "YAxis",
    };
};
