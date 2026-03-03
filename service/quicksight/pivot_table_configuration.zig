const DashboardCustomizationVisualOptions = @import("dashboard_customization_visual_options.zig").DashboardCustomizationVisualOptions;
const PivotTableFieldOptions = @import("pivot_table_field_options.zig").PivotTableFieldOptions;
const PivotTableFieldWells = @import("pivot_table_field_wells.zig").PivotTableFieldWells;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const PivotTablePaginatedReportOptions = @import("pivot_table_paginated_report_options.zig").PivotTablePaginatedReportOptions;
const PivotTableSortConfiguration = @import("pivot_table_sort_configuration.zig").PivotTableSortConfiguration;
const PivotTableOptions = @import("pivot_table_options.zig").PivotTableOptions;
const PivotTableTotalOptions = @import("pivot_table_total_options.zig").PivotTableTotalOptions;

/// The configuration for a `PivotTableVisual`.
pub const PivotTableConfiguration = struct {
    /// The options that define customizations available to dashboard readers for a
    /// specific visual
    dashboard_customization_visual_options: ?DashboardCustomizationVisualOptions = null,

    /// The field options for a pivot table visual.
    field_options: ?PivotTableFieldOptions = null,

    /// The field wells of the visual.
    field_wells: ?PivotTableFieldWells = null,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions = null,

    /// The paginated report options for a pivot table visual.
    paginated_report_options: ?PivotTablePaginatedReportOptions = null,

    /// The sort configuration for a `PivotTableVisual`.
    sort_configuration: ?PivotTableSortConfiguration = null,

    /// The table options for a pivot table visual.
    table_options: ?PivotTableOptions = null,

    /// The total options for a pivot table visual.
    total_options: ?PivotTableTotalOptions = null,

    pub const json_field_names = .{
        .dashboard_customization_visual_options = "DashboardCustomizationVisualOptions",
        .field_options = "FieldOptions",
        .field_wells = "FieldWells",
        .interactions = "Interactions",
        .paginated_report_options = "PaginatedReportOptions",
        .sort_configuration = "SortConfiguration",
        .table_options = "TableOptions",
        .total_options = "TotalOptions",
    };
};
