const DashboardFilterAttribute = @import("dashboard_filter_attribute.zig").DashboardFilterAttribute;
const FilterOperator = @import("filter_operator.zig").FilterOperator;

/// A filter that you apply when searching for dashboards.
pub const DashboardSearchFilter = struct {
    /// The name of the value that you want to use as a filter, for example,
    /// `"Name":
    /// "QUICKSIGHT_OWNER"`.
    ///
    /// Valid values are defined as follows:
    ///
    /// * `QUICKSIGHT_VIEWER_OR_OWNER`: Provide an ARN of a user or group, and any
    ///   dashboards with that ARN listed as one of the dashboards's owners or
    ///   viewers are returned. Implicit permissions from folders or groups are
    ///   considered.
    ///
    /// * `QUICKSIGHT_OWNER`: Provide an ARN of a user or group, and any dashboards
    ///   with that ARN listed as one of the owners of the dashboards are returned.
    ///   Implicit permissions from folders or groups are considered.
    ///
    /// * `DIRECT_QUICKSIGHT_SOLE_OWNER`: Provide an ARN of a user or group, and any
    ///   dashboards with that ARN listed as the only owner of the dashboard are
    ///   returned. Implicit permissions from folders or groups are not considered.
    ///
    /// * `DIRECT_QUICKSIGHT_OWNER`: Provide an ARN of a user or group, and any
    ///   dashboards with that ARN listed as one of the owners of the dashboards are
    ///   returned. Implicit permissions from folders or groups are not considered.
    ///
    /// * `DIRECT_QUICKSIGHT_VIEWER_OR_OWNER`: Provide an ARN of a user or group,
    ///   and any dashboards with that ARN listed as one of the owners or viewers of
    ///   the dashboards are returned. Implicit permissions from folders or groups
    ///   are not considered.
    ///
    /// * `DASHBOARD_NAME`: Any dashboards whose names have a substring match to
    ///   this value will be returned.
    name: ?DashboardFilterAttribute = null,

    /// The comparison operator that you want to use as a filter, for example
    /// `"Operator": "StringEquals"`. Valid values are `"StringEquals"` and
    /// `"StringLike"`.
    ///
    /// If you set the operator value to `"StringEquals"`, you need to provide an
    /// ownership related filter in the `"NAME"` field and the arn of the user or
    /// group whose folders you want to search in the `"Value"` field. For example,
    /// `"Name":"DIRECT_QUICKSIGHT_OWNER", "Operator": "StringEquals", "Value":
    /// "arn:aws:quicksight:us-east-1:1:user/default/UserName1"`.
    ///
    /// If you set the value to `"StringLike"`, you need to provide the name of the
    /// folders you are searching for. For example, `"Name":"DASHBOARD_NAME",
    /// "Operator": "StringLike", "Value": "Test"`. The `"StringLike"` operator only
    /// supports the `NAME` value `DASHBOARD_NAME`.
    operator: FilterOperator,

    /// The value of the named item, in this case `QUICKSIGHT_USER`, that you want
    /// to use as a filter, for example, `"Value":
    /// "arn:aws:quicksight:us-east-1:1:user/default/UserName1"`.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .operator = "Operator",
        .value = "Value",
    };
};
