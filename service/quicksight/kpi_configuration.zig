const KPIFieldWells = @import("kpi_field_wells.zig").KPIFieldWells;
const VisualInteractionOptions = @import("visual_interaction_options.zig").VisualInteractionOptions;
const KPIOptions = @import("kpi_options.zig").KPIOptions;
const KPISortConfiguration = @import("kpi_sort_configuration.zig").KPISortConfiguration;

/// The configuration of a KPI visual.
pub const KPIConfiguration = struct {
    /// The field well configuration of a KPI visual.
    field_wells: ?KPIFieldWells = null,

    /// The general visual interactions setup for a visual.
    interactions: ?VisualInteractionOptions = null,

    /// The options that determine the presentation of a KPI visual.
    kpi_options: ?KPIOptions = null,

    /// The sort configuration of a KPI visual.
    sort_configuration: ?KPISortConfiguration = null,

    pub const json_field_names = .{
        .field_wells = "FieldWells",
        .interactions = "Interactions",
        .kpi_options = "KPIOptions",
        .sort_configuration = "SortConfiguration",
    };
};
