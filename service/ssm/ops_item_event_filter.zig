const OpsItemEventFilterKey = @import("ops_item_event_filter_key.zig").OpsItemEventFilterKey;
const OpsItemEventFilterOperator = @import("ops_item_event_filter_operator.zig").OpsItemEventFilterOperator;

/// Describes a filter for a specific list of OpsItem events. You can filter
/// event information
/// by using tags. You specify tags by using a key-value pair mapping.
pub const OpsItemEventFilter = struct {
    /// The name of the filter key. Currently, the only supported value is
    /// `OpsItemId`.
    key: OpsItemEventFilterKey,

    /// The operator used by the filter call. Currently, the only supported value is
    /// `Equal`.
    operator: OpsItemEventFilterOperator,

    /// The values for the filter, consisting of one or more OpsItem IDs.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .operator = "Operator",
        .values = "Values",
    };
};
