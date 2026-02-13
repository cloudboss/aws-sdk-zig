const AssociationExecutionTargetsFilterKey = @import("association_execution_targets_filter_key.zig").AssociationExecutionTargetsFilterKey;

/// Filters for the association execution.
pub const AssociationExecutionTargetsFilter = struct {
    /// The key value used in the request.
    key: AssociationExecutionTargetsFilterKey,

    /// The value specified for the key.
    value: []const u8,

    pub const json_field_names = .{
        .key = "Key",
        .value = "Value",
    };
};
