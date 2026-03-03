const DashboardCustomizationVisualOptions = @import("dashboard_customization_visual_options.zig").DashboardCustomizationVisualOptions;
const TableFieldOptions = @import("table_field_options.zig").TableFieldOptions;
const TableFieldWells = @import("table_field_wells.zig").TableFieldWells;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const TablePaginatedReportOptions = @import("table_paginated_report_options.zig").TablePaginatedReportOptions;
const TableSortConfiguration = @import("table_sort_configuration.zig").TableSortConfiguration;
const TableInlineVisualization = @import("table_inline_visualization.zig").TableInlineVisualization;
const TableOptions = @import("table_options.zig").TableOptions;
const TotalOptions = @import("total_options.zig").TotalOptions;

/// The configuration for a `TableVisual`.
pub const TableConfiguration = struct {
    /// The options that define customizations available to dashboard readers for a
    /// specific visual
    dashboard_customization_visual_options: ?DashboardCustomizationVisualOptions = null,

    /// The field options for a table visual.
    field_options: ?TableFieldOptions = null,

    /// The field wells of the visual.
    field_wells: ?TableFieldWells = null,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions = null,

    /// The paginated report options for a table visual.
    paginated_report_options: ?TablePaginatedReportOptions = null,

    /// The sort configuration for a `TableVisual`.
    sort_configuration: ?TableSortConfiguration = null,

    /// A collection of inline visualizations to display within a chart.
    table_inline_visualizations: ?[]const TableInlineVisualization = null,

    /// The table options for a table visual.
    table_options: ?TableOptions = null,

    /// The total options for a table visual.
    total_options: ?TotalOptions = null,

    pub const json_field_names = .{
        .dashboard_customization_visual_options = "DashboardCustomizationVisualOptions",
        .field_options = "FieldOptions",
        .field_wells = "FieldWells",
        .interactions = "Interactions",
        .paginated_report_options = "PaginatedReportOptions",
        .sort_configuration = "SortConfiguration",
        .table_inline_visualizations = "TableInlineVisualizations",
        .table_options = "TableOptions",
        .total_options = "TotalOptions",
    };
};
