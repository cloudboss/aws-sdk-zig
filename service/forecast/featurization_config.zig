const Featurization = @import("featurization.zig").Featurization;

/// This object belongs to the CreatePredictor operation. If you created
/// your predictor with CreateAutoPredictor, see AttributeConfig.
///
/// In a CreatePredictor operation, the specified algorithm trains a model
/// using the specified dataset group. You can optionally tell the operation to
/// modify data fields
/// prior to training a model. These modifications are referred to as
/// *featurization*.
///
/// You define featurization using the `FeaturizationConfig` object. You specify
/// an
/// array of transformations, one for each field that you want to featurize. You
/// then include the
/// `FeaturizationConfig` object in your `CreatePredictor` request.
/// Amazon Forecast applies the featurization to the `TARGET_TIME_SERIES` and
/// `RELATED_TIME_SERIES` datasets before model training.
///
/// You can create multiple featurization configurations. For example, you might
/// call the
/// `CreatePredictor` operation twice by specifying different featurization
/// configurations.
pub const FeaturizationConfig = struct {
    /// An array of featurization (transformation) information for the fields of a
    /// dataset.
    featurizations: ?[]const Featurization,

    /// An array of dimension (field) names that specify how to group the generated
    /// forecast.
    ///
    /// For example, suppose that you are generating a forecast for item sales
    /// across all of your
    /// stores, and your dataset contains a `store_id` field. If you want the sales
    /// forecast for each item by store, you would specify `store_id` as the
    /// dimension.
    ///
    /// All forecast dimensions specified in the `TARGET_TIME_SERIES` dataset don't
    /// need to be specified in the `CreatePredictor` request. All forecast
    /// dimensions
    /// specified in the `RELATED_TIME_SERIES` dataset must be specified in the
    /// `CreatePredictor` request.
    forecast_dimensions: ?[]const []const u8,

    /// The frequency of predictions in a forecast.
    ///
    /// Valid intervals are an integer followed by Y (Year), M (Month), W (Week), D
    /// (Day), H (Hour), and min (Minute). For example,
    /// "1D" indicates every day and "15min" indicates every 15 minutes. You cannot
    /// specify a value that would overlap with the next larger frequency. That
    /// means, for example, you cannot specify a frequency of 60 minutes, because
    /// that is equivalent to 1 hour. The valid values for each frequency are the
    /// following:
    ///
    /// * Minute - 1-59
    ///
    /// * Hour - 1-23
    ///
    /// * Day - 1-6
    ///
    /// * Week - 1-4
    ///
    /// * Month - 1-11
    ///
    /// * Year - 1
    ///
    /// Thus, if you want every other week forecasts, specify "2W". Or, if you want
    /// quarterly forecasts, you specify "3M".
    ///
    /// The frequency must be greater than or equal to the TARGET_TIME_SERIES
    /// dataset
    /// frequency.
    ///
    /// When a RELATED_TIME_SERIES dataset is provided, the frequency must be equal
    /// to the
    /// TARGET_TIME_SERIES dataset frequency.
    forecast_frequency: []const u8,

    pub const json_field_names = .{
        .featurizations = "Featurizations",
        .forecast_dimensions = "ForecastDimensions",
        .forecast_frequency = "ForecastFrequency",
    };
};
