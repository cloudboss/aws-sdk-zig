const ActionConnectorSearchFilterNameEnum = @import("action_connector_search_filter_name_enum.zig").ActionConnectorSearchFilterNameEnum;
const FilterOperator = @import("filter_operator.zig").FilterOperator;

/// A filter used to search for action connectors based on specific criteria.
pub const ActionConnectorSearchFilter = struct {
    /// The name of the filter attribute (e.g., ACTION_CONNECTOR_NAME,
    /// ACTION_CONNECTOR_TYPE, QUICKSIGHT_VIEWER_OR_OWNER).
    name: ActionConnectorSearchFilterNameEnum,

    /// The comparison operator to use for the filter (e.g., StringEquals,
    /// StringLike).
    operator: FilterOperator,

    /// The value to compare against using the specified operator.
    value: []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .operator = "Operator",
        .value = "Value",
    };
};
