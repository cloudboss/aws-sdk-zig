const DimensionValues = @import("dimension_values.zig").DimensionValues;

/// Use `Expression` to filter in the `GetFreeTierUsage` API operation.
///
/// You can use the following patterns:
///
/// * Simple dimension values (`Dimensions` root operator)
/// * Complex expressions with logical operators (`AND`, `NOT`, and `OR` root
///   operators).
///
/// For *simple dimension values*, you can set the dimension name, values, and
/// match type for the filters that you plan to use.
///
/// **Example for simple dimension values**
///
/// You can filter to match exactly for `REGION==us-east-1 OR
/// REGION==us-west-1`.
///
/// The corresponding `Expression` appears like the following: `{ "Dimensions":
/// { "Key": "REGION", "Values": [ "us-east-1", "us-west-1" ], "MatchOptions":
/// ["EQUALS"] } }`
///
/// As shown in the previous example, lists of dimension values are combined
/// with `OR` when you apply the filter.
///
/// For *complex expressions with logical operators*, you can have nested
/// expressions to use the logical operators and specify advanced filtering.
///
/// **Example for complex expressions with logical operators**
///
/// You can filter by `((REGION == us-east-1 OR REGION == us-west-1) OR (SERVICE
/// CONTAINS AWSLambda)) AND (USAGE_TYPE !CONTAINS DataTransfer)`.
///
/// The corresponding `Expression` appears like the following: `{ "And": [
/// {"Or": [ {"Dimensions": { "Key": "REGION", "Values": [ "us-east-1",
/// "us-west-1" ], "MatchOptions": ["EQUALS"] }}, {"Dimensions": { "Key":
/// "SERVICE", "Values": ["AWSLambda"], "MatchOptions": ["CONTAINS"] } } ]},
/// {"Not": {"Dimensions": { "Key": "USAGE_TYPE", "Values": ["DataTransfer"],
/// "MatchOptions": ["CONTAINS"] }}} ] }`
///
/// In the following **Contents**, you must specify exactly one of the following
/// root operators.
pub const Expression = struct {
    /// Return results that match all `Expressions` that you specified in the array.
    @"and": ?[]const Expression,

    /// The specific dimension, values, and match type to filter objects with.
    dimensions: ?DimensionValues,

    /// Return results that don’t match the `Expression` that you specified.
    not: ?*Expression = null,

    /// Return results that match any of the `Expressions` that you specified. in
    /// the array.
    @"or": ?[]const Expression,

    pub const json_field_names = .{
        .@"and" = "And",
        .dimensions = "Dimensions",
        .not = "Not",
        .@"or" = "Or",
    };
};
