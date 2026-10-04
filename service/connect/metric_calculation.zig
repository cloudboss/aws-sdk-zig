const CalculationComponent = @import("calculation_component.zig").CalculationComponent;

/// Contains the formula and component metrics that define a custom metric
/// calculation.
pub const MetricCalculation = struct {
    /// The formula expression that defines how the metric is calculated. Uses
    /// component aliases (for example, `100 * SUM(M1) / SUM(M2)`).
    calculation: []const u8,

    /// The list of component metrics referenced in the calculation formula. Each
    /// component has an alias used in the formula expression.
    calculation_components: []const CalculationComponent,

    pub const json_field_names = .{
        .calculation = "Calculation",
        .calculation_components = "CalculationComponents",
    };
};
