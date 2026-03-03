const aws = @import("aws");

const AggregationTransformationValue = @import("aggregation_transformation_value.zig").AggregationTransformationValue;

/// Transformations allowed on the dataset. Supported transformations are
/// `Filling` and `Aggregation`. `Filling` specifies how to add values to
/// missing values in the dataset. `Aggregation` defines how to aggregate data
/// that does not align with forecast frequency.
pub const TimeSeriesTransformations = struct {
    /// A key value pair defining the aggregation method for a column, where the key
    /// is the column name and the value is the aggregation method.
    ///
    /// The supported aggregation methods are `sum` (default), `avg`, `first`,
    /// `min`, `max`.
    ///
    /// Aggregation is only supported for the target column.
    aggregation: ?[]const aws.map.MapEntry(AggregationTransformationValue) = null,

    /// A key value pair defining the filling method for a column, where the key is
    /// the column name and the value is an object which defines the filling logic.
    /// You can specify multiple filling methods for a single column.
    ///
    /// The supported filling methods and their corresponding options are:
    ///
    /// * `frontfill`: `none` (Supported only for target column)
    /// * `middlefill`: `zero`, `value`, `median`, `mean`, `min`, `max`
    /// * `backfill`: `zero`, `value`, `median`, `mean`, `min`, `max`
    /// * `futurefill`: `zero`, `value`, `median`, `mean`, `min`, `max`
    ///
    /// To set a filling method to a specific value, set the fill parameter to the
    /// chosen filling method value (for example `"backfill" : "value"`), and define
    /// the filling value in an additional parameter prefixed with "_value". For
    /// example, to set `backfill` to a value of `2`, you must include two
    /// parameters: `"backfill": "value"` and `"backfill_value":"2"`.
    filling: ?[]const aws.map.MapEntry([]const aws.map.StringMapEntry) = null,

    pub const json_field_names = .{
        .aggregation = "Aggregation",
        .filling = "Filling",
    };
};
