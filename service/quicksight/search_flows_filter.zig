const FieldName = @import("field_name.zig").FieldName;
const SearchFilterOperator = @import("search_filter_operator.zig").SearchFilterOperator;

/// A structure that contains the filter information when searching flows.
pub const SearchFlowsFilter = struct {
    /// The name of the value that you want to use as a filter, for example `"Name":
    /// "DIRECT_QUICKSIGHT_SOLE_OWNER"`.
    ///
    /// Valid values are defined as follows:
    ///
    /// * `assetName`: Any flows whose names have a substring match to this value
    ///   will be returned.
    ///
    /// * `assetDescription`: Any flows whose descriptions have a substring match to
    ///   this value will be returned.
    ///
    /// * `DIRECT_QUICKSIGHT_SOLE_OWNER`: Provide an ARN of a user or group, and any
    ///   analyses with that ARN listed as the only owner of the analysis are
    ///   returned. Implicit permissions from folders or groups are not considered.
    ///
    /// * `DIRECT_QUICKSIGHT_OWNER`: Provide an ARN of a user or group, and any
    ///   analyses with that ARN listed as one of the owners of the analyses are
    ///   returned. Implicit permissions from folders or groups are not considered.
    ///
    /// * `DIRECT_QUICKSIGHT_VIEWER_OR_OWNER`: Provide an ARN of a user or group,
    ///   and any analyses with that ARN listed as one of the owners or viewers of
    ///   the analyses are returned. Implicit permissions from folders or groups are
    ///   not considered.
    name: FieldName,

    /// The comparison operator that you want to use as a filter, for example
    /// `"Operator": "StringEquals"`. Valid values are `"StringEquals"` and
    /// `"StringLike"`.
    operator: SearchFilterOperator,

    /// The value of the named item, in this case `DIRECT_QUICKSIGHT_SOLE_OWNER`,
    /// that you want
    /// to use as a filter, for example `"Value"`. An example is
    /// `"arn:aws:quicksight:us-east-1:1:user/default/UserName1"`.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .operator = "Operator",
        .value = "Value",
    };
};
