const CandidateGenerationConfig = @import("candidate_generation_config.zig").CandidateGenerationConfig;
const AutoMLJobCompletionCriteria = @import("auto_ml_job_completion_criteria.zig").AutoMLJobCompletionCriteria;
const HolidayConfigAttributes = @import("holiday_config_attributes.zig").HolidayConfigAttributes;
const TimeSeriesConfig = @import("time_series_config.zig").TimeSeriesConfig;
const TimeSeriesTransformations = @import("time_series_transformations.zig").TimeSeriesTransformations;

/// The collection of settings used by an AutoML job V2 for the time-series
/// forecasting problem type.
pub const TimeSeriesForecastingJobConfig = struct {
    candidate_generation_config: ?CandidateGenerationConfig,

    completion_criteria: ?AutoMLJobCompletionCriteria,

    /// A URL to the Amazon S3 data source containing additional selected features
    /// that complement the target, itemID, timestamp, and grouped columns set in
    /// `TimeSeriesConfig`. When not provided, the AutoML job V2 includes all the
    /// columns from the original dataset that are not already declared in
    /// `TimeSeriesConfig`. If provided, the AutoML job V2 only considers these
    /// additional columns as a complement to the ones declared in
    /// `TimeSeriesConfig`.
    ///
    /// You can input `FeatureAttributeNames` (optional) in JSON format as shown
    /// below:
    ///
    /// `{ "FeatureAttributeNames":["col1", "col2", ...] }`.
    ///
    /// You can also specify the data type of the feature (optional) in the format
    /// shown below:
    ///
    /// `{ "FeatureDataTypes":{"col1":"numeric", "col2":"categorical" ... } }`
    ///
    /// Autopilot supports the following data types: `numeric`, `categorical`,
    /// `text`, and `datetime`.
    ///
    /// These column keys must not include any column set in `TimeSeriesConfig`.
    feature_specification_s3_uri: ?[]const u8,

    /// The frequency of predictions in a forecast.
    ///
    /// Valid intervals are an integer followed by Y (Year), M (Month), W (Week), D
    /// (Day), H (Hour), and min (Minute). For example, `1D` indicates every day and
    /// `15min` indicates every 15 minutes. The value of a frequency must not
    /// overlap with the next larger frequency. For example, you must use a
    /// frequency of `1H` instead of `60min`.
    ///
    /// The valid values for each frequency are the following:
    ///
    /// * Minute - 1-59
    /// * Hour - 1-23
    /// * Day - 1-6
    /// * Week - 1-4
    /// * Month - 1-11
    /// * Year - 1
    forecast_frequency: []const u8,

    /// The number of time-steps that the model predicts. The forecast horizon is
    /// also called the prediction length. The maximum forecast horizon is the
    /// lesser of 500 time-steps or 1/4 of the time-steps in the dataset.
    forecast_horizon: i32,

    /// The quantiles used to train the model for forecasts at a specified quantile.
    /// You can specify quantiles from `0.01` (p1) to `0.99` (p99), by increments of
    /// 0.01 or higher. Up to five forecast quantiles can be specified. When
    /// `ForecastQuantiles` is not provided, the AutoML job uses the quantiles p10,
    /// p50, and p90 as default.
    forecast_quantiles: ?[]const []const u8,

    /// The collection of holiday featurization attributes used to incorporate
    /// national holiday information into your forecasting model.
    holiday_config: ?[]const HolidayConfigAttributes,

    /// The collection of components that defines the time-series.
    time_series_config: TimeSeriesConfig,

    /// The transformations modifying specific attributes of the time-series, such
    /// as filling strategies for missing values.
    transformations: ?TimeSeriesTransformations,

    pub const json_field_names = .{
        .candidate_generation_config = "CandidateGenerationConfig",
        .completion_criteria = "CompletionCriteria",
        .feature_specification_s3_uri = "FeatureSpecificationS3Uri",
        .forecast_frequency = "ForecastFrequency",
        .forecast_horizon = "ForecastHorizon",
        .forecast_quantiles = "ForecastQuantiles",
        .holiday_config = "HolidayConfig",
        .time_series_config = "TimeSeriesConfig",
        .transformations = "Transformations",
    };
};
