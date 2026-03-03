const aws = @import("aws");

const OpsFilter = @import("ops_filter.zig").OpsFilter;

/// One or more aggregators for viewing counts of OpsData using different
/// dimensions such as
/// `Source`, `CreatedTime`, or `Source and CreatedTime`, to name a
/// few.
pub const OpsAggregator = struct {
    /// A nested aggregator for viewing counts of OpsData.
    aggregators: ?[]const OpsAggregator = null,

    /// Either a `Range` or `Count` aggregator for limiting an OpsData
    /// summary.
    aggregator_type: ?[]const u8 = null,

    /// The name of an OpsData attribute on which to limit the count of OpsData.
    attribute_name: ?[]const u8 = null,

    /// The aggregator filters.
    filters: ?[]const OpsFilter = null,

    /// The data type name to use for viewing counts of OpsData.
    type_name: ?[]const u8 = null,

    /// The aggregator value.
    values: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .aggregators = "Aggregators",
        .aggregator_type = "AggregatorType",
        .attribute_name = "AttributeName",
        .filters = "Filters",
        .type_name = "TypeName",
        .values = "Values",
    };
};
