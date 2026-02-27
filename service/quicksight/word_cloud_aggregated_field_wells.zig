const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The aggregated field wells of a word cloud.
pub const WordCloudAggregatedFieldWells = struct {
    /// The group by field well of a word cloud. Values are grouped by group by
    /// fields.
    group_by: ?[]const DimensionField,

    /// The size field well of a word cloud. Values are aggregated based on group by
    /// fields.
    size: ?[]const MeasureField,

    pub const json_field_names = .{
        .group_by = "GroupBy",
        .size = "Size",
    };
};
