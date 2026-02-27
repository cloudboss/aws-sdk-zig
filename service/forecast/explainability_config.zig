const TimePointGranularity = @import("time_point_granularity.zig").TimePointGranularity;
const TimeSeriesGranularity = @import("time_series_granularity.zig").TimeSeriesGranularity;

/// The ExplainabilityConfig data type defines the number of time series and
/// time points
/// included in CreateExplainability.
///
/// If you provide a predictor ARN for `ResourceArn`, you must set both
/// `TimePointGranularity` and `TimeSeriesGranularity` to “ALL”.
/// When creating Predictor Explainability, Amazon Forecast considers all time
/// series and
/// time points.
///
/// If you provide a forecast ARN for `ResourceArn`, you can set
/// `TimePointGranularity` and `TimeSeriesGranularity` to either
/// “ALL” or “Specific”.
pub const ExplainabilityConfig = struct {
    /// To create an Explainability for all time points in your forecast horizon,
    /// use
    /// `ALL`. To create an Explainability for specific time points in your
    /// forecast horizon, use `SPECIFIC`.
    ///
    /// Specify time points with the `StartDateTime` and `EndDateTime`
    /// parameters within the CreateExplainability operation.
    time_point_granularity: TimePointGranularity,

    /// To create an Explainability for all time series in your datasets, use
    /// `ALL`. To create an Explainability for specific time series in your
    /// datasets,
    /// use `SPECIFIC`.
    ///
    /// Specify time series by uploading a CSV or Parquet file to an Amazon S3
    /// bucket and set the location
    /// within the DataDestination data type.
    time_series_granularity: TimeSeriesGranularity,

    pub const json_field_names = .{
        .time_point_granularity = "TimePointGranularity",
        .time_series_granularity = "TimeSeriesGranularity",
    };
};
