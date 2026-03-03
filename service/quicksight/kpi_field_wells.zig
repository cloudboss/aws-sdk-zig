const MeasureField = @import("measure_field.zig").MeasureField;
const DimensionField = @import("dimension_field.zig").DimensionField;

/// The field well configuration of a KPI visual.
pub const KPIFieldWells = struct {
    /// The target value field wells of a KPI visual.
    target_values: ?[]const MeasureField = null,

    /// The trend group field wells of a KPI visual.
    trend_groups: ?[]const DimensionField = null,

    /// The value field wells of a KPI visual.
    values: ?[]const MeasureField = null,

    pub const json_field_names = .{
        .target_values = "TargetValues",
        .trend_groups = "TrendGroups",
        .values = "Values",
    };
};
