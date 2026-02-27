const FeaturizationMethod = @import("featurization_method.zig").FeaturizationMethod;

/// This object belongs to the CreatePredictor operation. If you created
/// your predictor with CreateAutoPredictor, see AttributeConfig.
///
/// Provides featurization (transformation) information for a dataset field.
/// This object is
/// part of the FeaturizationConfig object.
///
/// For example:
///
/// `{`
///
/// `"AttributeName": "demand",`
///
/// `FeaturizationPipeline [ {`
///
/// `"FeaturizationMethodName": "filling",`
///
/// `"FeaturizationMethodParameters": {"aggregation": "avg", "backfill":
/// "nan"}`
///
/// `} ]`
///
/// `}`
pub const Featurization = struct {
    /// The name of the schema attribute that specifies the data field to be
    /// featurized. Amazon
    /// Forecast supports the target field of the `TARGET_TIME_SERIES` and the
    /// `RELATED_TIME_SERIES` datasets. For example, for the `RETAIL` domain,
    /// the target is `demand`, and for the `CUSTOM` domain, the target is
    /// `target_value`. For more information, see howitworks-missing-values.
    attribute_name: []const u8,

    /// An array of one `FeaturizationMethod` object that specifies the feature
    /// transformation method.
    featurization_pipeline: ?[]const FeaturizationMethod,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .featurization_pipeline = "FeaturizationPipeline",
    };
};
