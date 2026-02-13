const AssociationExecutionFilterKey = @import("association_execution_filter_key.zig").AssociationExecutionFilterKey;
const AssociationFilterOperatorType = @import("association_filter_operator_type.zig").AssociationFilterOperatorType;

/// Filters used in the request.
pub const AssociationExecutionFilter = struct {
    /// The key value used in the request.
    key: AssociationExecutionFilterKey,

    /// The filter type specified in the request.
    @"type": AssociationFilterOperatorType,

    /// The value specified for the key.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .@"type" = "Type",
        .value = "Value",
    };
};
