const BatchDeleteByResourceArns = @import("batch_delete_by_resource_arns.zig").BatchDeleteByResourceArns;
const BatchDeleteScope = @import("batch_delete_scope.zig").BatchDeleteScope;

/// Union type for batch delete target selection.
/// Exactly one of the two modes must be specified.
pub const BatchDeleteDeletionTarget = union(enum) {
    /// Delete specific configurations by ARN list.
    resource_arns: ?BatchDeleteByResourceArns,
    /// Delete all configurations matching the specified scope.
    scope: ?BatchDeleteScope,

    pub const json_field_names = .{
        .resource_arns = "ResourceArns",
        .scope = "Scope",
    };
};
