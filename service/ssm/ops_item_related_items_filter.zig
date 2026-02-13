const OpsItemRelatedItemsFilterKey = @import("ops_item_related_items_filter_key.zig").OpsItemRelatedItemsFilterKey;
const OpsItemRelatedItemsFilterOperator = @import("ops_item_related_items_filter_operator.zig").OpsItemRelatedItemsFilterOperator;

/// Describes a filter for a specific list of related-item resources.
pub const OpsItemRelatedItemsFilter = struct {
    /// The name of the filter key. Supported values include `ResourceUri`,
    /// `ResourceType`, or `AssociationId`.
    key: OpsItemRelatedItemsFilterKey,

    /// The operator used by the filter call. The only supported operator is
    /// `EQUAL`.
    operator: OpsItemRelatedItemsFilterOperator,

    /// The values for the filter.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .operator = "Operator",
        .values = "Values",
    };
};
