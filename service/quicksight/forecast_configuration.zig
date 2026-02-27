const TimeBasedForecastProperties = @import("time_based_forecast_properties.zig").TimeBasedForecastProperties;
const ForecastScenario = @import("forecast_scenario.zig").ForecastScenario;

/// The forecast configuration that is used in a line chart's display
/// properties.
pub const ForecastConfiguration = struct {
    /// The forecast properties setup of a forecast in the line
    /// chart.
    forecast_properties: ?TimeBasedForecastProperties,

    /// The forecast scenario of a forecast in the line chart.
    scenario: ?ForecastScenario,

    pub const json_field_names = .{
        .forecast_properties = "ForecastProperties",
        .scenario = "Scenario",
    };
};
