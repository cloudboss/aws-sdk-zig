const ForecastComputationSeasonality = @import("forecast_computation_seasonality.zig").ForecastComputationSeasonality;
const DimensionField = @import("dimension_field.zig").DimensionField;
const MeasureField = @import("measure_field.zig").MeasureField;

/// The forecast computation configuration.
pub const ForecastComputation = struct {
    /// The ID for a computation.
    computation_id: []const u8,

    /// The custom seasonality value setup of a forecast computation.
    custom_seasonality_value: ?i32 = null,

    /// The lower boundary setup of a forecast computation.
    lower_boundary: ?f64 = null,

    /// The name of a computation.
    name: ?[]const u8 = null,

    /// The periods backward setup of a forecast computation.
    periods_backward: ?i32 = null,

    /// The periods forward setup of a forecast computation.
    periods_forward: ?i32 = null,

    /// The prediction interval setup of a forecast computation.
    prediction_interval: ?i32 = null,

    /// The seasonality setup of a forecast computation. Choose one of the following
    /// options:
    ///
    /// * `AUTOMATIC`
    ///
    /// * `CUSTOM`: Checks the custom seasonality value.
    seasonality: ?ForecastComputationSeasonality = null,

    /// The time field that is used in a computation.
    time: ?DimensionField = null,

    /// The upper boundary setup of a forecast computation.
    upper_boundary: ?f64 = null,

    /// The value field that is used in a computation.
    value: ?MeasureField = null,

    pub const json_field_names = .{
        .computation_id = "ComputationId",
        .custom_seasonality_value = "CustomSeasonalityValue",
        .lower_boundary = "LowerBoundary",
        .name = "Name",
        .periods_backward = "PeriodsBackward",
        .periods_forward = "PeriodsForward",
        .prediction_interval = "PredictionInterval",
        .seasonality = "Seasonality",
        .time = "Time",
        .upper_boundary = "UpperBoundary",
        .value = "Value",
    };
};
