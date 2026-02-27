const DataSourceFilterAttribute = @import("data_source_filter_attribute.zig").DataSourceFilterAttribute;
const FilterOperator = @import("filter_operator.zig").FilterOperator;

/// A filter that you apply when searching for data sources.
pub const DataSourceSearchFilter = struct {
    /// The name of the value that you want to use as a filter, for example,
    /// `"Name":
    /// "DIRECT_QUICKSIGHT_OWNER"`.
    ///
    /// Valid values are defined as follows:
    ///
    /// * `DIRECT_QUICKSIGHT_VIEWER_OR_OWNER`: Provide an ARN of a user or group,
    ///   and any data sources with that ARN listed as one of the owners or viewers
    ///   of the data sources are returned. Implicit permissions from folders or
    ///   groups are not considered.
    ///
    /// * `DIRECT_QUICKSIGHT_OWNER`: Provide an ARN of a user or group, and any data
    ///   sources with that ARN listed as one of the owners if the data source are
    ///   returned. Implicit permissions from folders or groups are not considered.
    ///
    /// * `DIRECT_QUICKSIGHT_SOLE_OWNER`: Provide an ARN of a user or group, and any
    ///   data sources with that ARN listed as the only owner of the data source are
    ///   returned. Implicit permissions from folders or groups are not considered.
    ///
    /// * `DATASOURCE_NAME`: Any data sources whose names have a substring match to
    ///   the provided value are returned.
    name: DataSourceFilterAttribute,

    /// The comparison operator that you want to use as a filter, for example
    /// `"Operator": "StringEquals"`. Valid values are `"StringEquals"` and
    /// `"StringLike"`.
    ///
    /// If you set the operator value to `"StringEquals"`, you need to provide an
    /// ownership related filter in the `"NAME"` field and the arn of the user or
    /// group whose data sources you want to search in the `"Value"` field. For
    /// example, `"Name":"DIRECT_QUICKSIGHT_OWNER", "Operator": "StringEquals",
    /// "Value": "arn:aws:quicksight:us-east-1:1:user/default/UserName1"`.
    ///
    /// If you set the value to `"StringLike"`, you need to provide the name of the
    /// data sources you are searching for. For example, `"Name":"DATASOURCE_NAME",
    /// "Operator": "StringLike", "Value": "Test"`. The `"StringLike"` operator only
    /// supports the `NAME` value `DATASOURCE_NAME`.
    operator: FilterOperator,

    /// The value of the named item, for example `DIRECT_QUICKSIGHT_OWNER`, that you
    /// want
    /// to use as a filter, for example, `"Value":
    /// "arn:aws:quicksight:us-east-1:1:user/default/UserName1"`.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .operator = "Operator",
        .value = "Value",
    };
};
