const AxisDisplayDataDrivenRange = @import("axis_display_data_driven_range.zig").AxisDisplayDataDrivenRange;
const AxisDisplayMinMaxRange = @import("axis_display_min_max_range.zig").AxisDisplayMinMaxRange;

/// The range setup of a numeric axis display range.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const AxisDisplayRange = struct {
    /// The data-driven setup of an axis display range.
    data_driven: ?AxisDisplayDataDrivenRange,

    /// The minimum and maximum setup of an axis display range.
    min_max: ?AxisDisplayMinMaxRange,

    pub const json_field_names = .{
        .data_driven = "DataDriven",
        .min_max = "MinMax",
    };
};
