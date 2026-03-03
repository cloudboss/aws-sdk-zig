const aws = @import("aws");

const FeaturizationMethodName = @import("featurization_method_name.zig").FeaturizationMethodName;

/// Provides information about the method that featurizes (transforms) a dataset
/// field. The
/// method is part of the `FeaturizationPipeline` of the Featurization object.
///
/// The following is an example of how you specify a `FeaturizationMethod`
/// object.
///
/// `{`
///
/// `"FeaturizationMethodName": "filling",`
///
/// `"FeaturizationMethodParameters": {"aggregation": "sum", "middlefill":
/// "zero",
/// "backfill": "zero"}`
///
/// `}`
pub const FeaturizationMethod = struct {
    /// The name of the method. The "filling" method is the only supported method.
    featurization_method_name: FeaturizationMethodName,

    /// The method parameters (key-value pairs), which are a map of override
    /// parameters. Specify
    /// these parameters to override the default values. Related Time Series
    /// attributes do not accept
    /// aggregation parameters.
    ///
    /// The following list shows the parameters and their valid values for the
    /// "filling"
    /// featurization method for a **Target Time Series** dataset. Bold
    /// signifies the default value.
    ///
    /// * `aggregation`: **sum**, `avg`,
    /// `first`, `min`, `max`
    ///
    /// * `frontfill`: **none**
    ///
    /// * `middlefill`: **zero**, `nan` (not
    /// a number), `value`, `median`, `mean`, `min`,
    /// `max`
    ///
    /// * `backfill`: **zero**, `nan`,
    /// `value`, `median`, `mean`, `min`,
    /// `max`
    ///
    /// The following list shows the parameters and their valid values for a
    /// **Related Time Series** featurization method (there are no defaults):
    ///
    /// * `middlefill`: `zero`, `value`, `median`,
    /// `mean`, `min`, `max`
    ///
    /// * `backfill`: `zero`, `value`, `median`,
    /// `mean`, `min`, `max`
    ///
    /// * `futurefill`: `zero`, `value`, `median`,
    /// `mean`, `min`, `max`
    ///
    /// To set a filling method to a specific value, set the fill parameter to
    /// `value`
    /// and define the value in a corresponding `_value` parameter. For example, to
    /// set
    /// backfilling to a value of 2, include the following: `"backfill": "value"`
    /// and
    /// `"backfill_value":"2"`.
    featurization_method_parameters: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .featurization_method_name = "FeaturizationMethodName",
        .featurization_method_parameters = "FeaturizationMethodParameters",
    };
};
