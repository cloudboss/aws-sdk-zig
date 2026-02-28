const KPIVisualStandardLayoutType = @import("kpi_visual_standard_layout_type.zig").KPIVisualStandardLayoutType;

/// The standard layout of the KPI visual.
pub const KPIVisualStandardLayout = struct {
    /// The standard layout type.
    @"type": KPIVisualStandardLayoutType,

    pub const json_field_names = .{
        .@"type" = "Type",
    };
};
