const NodeConfigurationOptionsFilterName = @import("node_configuration_options_filter_name.zig").NodeConfigurationOptionsFilterName;
const OperatorType = @import("operator_type.zig").OperatorType;

/// A set of elements to filter the returned node configurations.
pub const NodeConfigurationOptionsFilter = struct {
    /// The name of the element to filter.
    name: ?NodeConfigurationOptionsFilterName = null,

    /// The filter operator.
    /// If filter Name is NodeType only the 'in' operator is supported.
    /// Provide one value to evaluate for 'eq', 'lt', 'le', 'gt', and 'ge'.
    /// Provide two values to evaluate for 'between'.
    /// Provide a list of values for 'in'.
    operator: ?OperatorType = null,

    /// List of values. Compare Name using Operator to Values.
    /// If filter Name is NumberOfNodes, then values can range from 0 to 200.
    /// If filter Name is EstimatedDiskUtilizationPercent, then values can range
    /// from 0 to 100.
    /// For example, filter NumberOfNodes (name) GT (operator) 3 (values).
    values: ?[]const []const u8 = null,
};
