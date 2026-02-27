const NodeFilterKey = @import("node_filter_key.zig").NodeFilterKey;
const NodeFilterOperatorType = @import("node_filter_operator_type.zig").NodeFilterOperatorType;

/// The filters for the operation.
pub const NodeFilter = struct {
    /// The name of the filter.
    key: NodeFilterKey,

    /// The type of filter operator.
    type: ?NodeFilterOperatorType,

    /// A filter value supported by the specified key. For example, for the key
    /// `PlatformType`, supported values include `Linux` and
    /// `Windows`.
    values: []const []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .type = "Type",
        .values = "Values",
    };
};
