const ComparisonFormatConfiguration = @import("comparison_format_configuration.zig").ComparisonFormatConfiguration;
const ComparisonMethod = @import("comparison_method.zig").ComparisonMethod;

/// The comparison display configuration of a KPI or gauge chart.
pub const ComparisonConfiguration = struct {
    /// The format of the comparison.
    comparison_format: ?ComparisonFormatConfiguration = null,

    /// The method of the comparison. Choose from the following options:
    ///
    /// * `DIFFERENCE`
    ///
    /// * `PERCENT_DIFFERENCE`
    ///
    /// * `PERCENT`
    comparison_method: ?ComparisonMethod = null,

    pub const json_field_names = .{
        .comparison_format = "ComparisonFormat",
        .comparison_method = "ComparisonMethod",
    };
};
