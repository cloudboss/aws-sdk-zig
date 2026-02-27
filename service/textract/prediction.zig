/// Contains information regarding predicted values returned by Amazon Textract
/// operations, including the
/// predicted value and the confidence in the predicted value.
pub const Prediction = struct {
    /// Amazon Textract's confidence in its predicted value.
    confidence: ?f32,

    /// The predicted value of a detected object.
    value: ?[]const u8,

    pub const json_field_names = .{
        .confidence = "Confidence",
        .value = "Value",
    };
};
