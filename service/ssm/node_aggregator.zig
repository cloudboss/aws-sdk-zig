const NodeAggregatorType = @import("node_aggregator_type.zig").NodeAggregatorType;
const NodeAttributeName = @import("node_attribute_name.zig").NodeAttributeName;
const NodeTypeName = @import("node_type_name.zig").NodeTypeName;

/// One or more aggregators for viewing counts of nodes using different
/// dimensions.
pub const NodeAggregator = struct {
    /// Information about aggregators used to refine a node summary.
    aggregators: ?[]const NodeAggregator = null,

    /// The aggregator type for limiting a node summary. Currently, only `Count` is
    /// supported.
    aggregator_type: NodeAggregatorType,

    /// The name of a node attribute on which to limit the count of nodes.
    attribute_name: NodeAttributeName,

    /// The data type name to use for viewing counts of nodes. Currently, only
    /// `Instance`
    /// is supported.
    type_name: NodeTypeName,

    pub const json_field_names = .{
        .aggregators = "Aggregators",
        .aggregator_type = "AggregatorType",
        .attribute_name = "AttributeName",
        .type_name = "TypeName",
    };
};
