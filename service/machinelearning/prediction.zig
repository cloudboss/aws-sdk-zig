const aws = @import("aws");

/// The output from a `Predict` operation:
///
/// * `Details` - Contains the following attributes:
/// `DetailsAttributes.PREDICTIVE_MODEL_TYPE - REGRESSION | BINARY | MULTICLASS`
/// `DetailsAttributes.ALGORITHM - SGD`
///
/// * `PredictedLabel` - Present for either a `BINARY` or `MULTICLASS`
/// `MLModel` request.
///
/// * `PredictedScores` - Contains the raw classification score corresponding to
///   each label.
///
/// * `PredictedValue` - Present for a `REGRESSION`
/// `MLModel` request.
pub const Prediction = struct {
    details: ?[]const aws.map.StringMapEntry,

    /// The prediction label for either a `BINARY` or `MULTICLASS`
    /// `MLModel`.
    predicted_label: ?[]const u8,

    predicted_scores: ?[]const aws.map.MapEntry(f32),

    /// The prediction value for `REGRESSION`
    /// `MLModel`.
    predicted_value: ?f32,

    pub const json_field_names = .{
        .details = "details",
        .predicted_label = "predictedLabel",
        .predicted_scores = "predictedScores",
        .predicted_value = "predictedValue",
    };
};
