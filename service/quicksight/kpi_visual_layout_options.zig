const KPIVisualStandardLayout = @import("kpi_visual_standard_layout.zig").KPIVisualStandardLayout;

/// The options that determine the layout a KPI visual.
pub const KPIVisualLayoutOptions = struct {
    /// The standard layout of the KPI visual.
    standard_layout: ?KPIVisualStandardLayout,

    pub const json_field_names = .{
        .standard_layout = "StandardLayout",
    };
};
