const Operator = @import("operator.zig").Operator;

/// A filter that you use with the results of a Amazon CloudWatch Internet
/// Monitor query that you created and ran. The query sets up a
/// repository of data that is a subset of your application's Internet Monitor
/// data. `FilterParameter` is a string
/// that defines how you want to filter the repository of data to return a set
/// of results, based on your criteria.
///
/// The filter parameters that you can specify depend on the query type that you
/// used to create the repository, since
/// each query type returns a different set of Internet Monitor data.
///
/// For each filter, you specify a field (such as `city`), an operator (such as
/// `not_equals`,
/// and a value or array of values (such as `["Seattle", "Redmond"]`). Separate
/// values in the array with
/// commas.
///
/// For more information about specifying filter parameters, see
/// [Using the Amazon CloudWatch Internet Monitor query
/// interface](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-IM-view-cw-tools-cwim-query.html)
/// in the Amazon CloudWatch Internet Monitor User Guide.
pub const FilterParameter = struct {
    /// A data field that you want to filter, to further scope your application's
    /// Internet Monitor data in a repository that you
    /// created by running a query. A field might be `city`, for example. The field
    /// must be one of the fields
    /// that was returned by the specific query that you used to create the
    /// repository.
    field: ?[]const u8,

    /// The operator to use with the filter field and a value, such as `not_equals`.
    operator: ?Operator,

    /// One or more values to be used, together with the specified operator, to
    /// filter data for a query.
    /// For example, you could specify an array of values such as `["Seattle",
    /// "Redmond"]`. Values in the array are separated by
    /// commas.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .field = "Field",
        .operator = "Operator",
        .values = "Values",
    };
};
