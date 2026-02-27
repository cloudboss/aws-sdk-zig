const aws = @import("aws");

/// Provides information about the method used to transform attributes.
///
/// The following is an example using the RETAIL domain:
///
/// `{`
///
/// `"AttributeName": "demand",`
///
/// `"Transformations": {"aggregation": "sum", "middlefill": "zero", "backfill":
/// "zero"}`
///
/// `}`
pub const AttributeConfig = struct {
    /// The name of the attribute as specified in the schema. Amazon Forecast
    /// supports the
    /// target field of the target time series and the related time series datasets.
    /// For
    /// example, for the RETAIL domain, the target is `demand`.
    attribute_name: []const u8,

    /// The method parameters (key-value pairs), which are a map of override
    /// parameters.
    /// Specify these parameters to override the default values. Related Time Series
    /// attributes
    /// do not accept aggregation parameters.
    ///
    /// The following list shows the parameters and their valid values for the
    /// "filling"
    /// featurization method for a **Target Time Series** dataset.
    /// Default values are bolded.
    ///
    /// * `aggregation`: **sum**,
    /// `avg`, `first`, `min`,
    /// `max`
    ///
    /// * `frontfill`: **none**
    ///
    /// * `middlefill`: **zero**,
    /// `nan` (not a number), `value`, `median`,
    /// `mean`, `min`, `max`
    ///
    /// * `backfill`: **zero**,
    /// `nan`, `value`, `median`, `mean`,
    /// `min`, `max`
    ///
    /// The following list shows the parameters and their valid values for a
    /// **Related Time Series** featurization method (there are no
    /// defaults):
    ///
    /// * `middlefill`: `zero`, `value`,
    /// `median`, `mean`, `min`,
    /// `max`
    ///
    /// * `backfill`: `zero`, `value`,
    /// `median`, `mean`, `min`,
    /// `max`
    ///
    /// * `futurefill`: `zero`, `value`,
    /// `median`, `mean`, `min`,
    /// `max`
    ///
    /// To set a filling method to a specific value, set the fill parameter to
    /// `value` and define the value in a corresponding `_value`
    /// parameter. For example, to set backfilling to a value of 2, include the
    /// following:
    /// `"backfill": "value"` and `"backfill_value":"2"`.
    transformations: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .transformations = "Transformations",
    };
};
