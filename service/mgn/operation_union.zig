const DeleteOperation = @import("delete_operation.zig").DeleteOperation;
const MergeOperation = @import("merge_operation.zig").MergeOperation;
const SplitOperation = @import("split_operation.zig").SplitOperation;
const UpdateOperation = @import("update_operation.zig").UpdateOperation;

/// A union type representing the operation to perform on a construct during a
/// mapping update.
pub const OperationUnion = union(enum) {
    /// A delete operation to remove a construct from the mapping.
    delete: ?DeleteOperation,
    /// A merge operation to combine constructs from different segments.
    merge: ?MergeOperation,
    /// A split operation to divide a construct into multiple constructs with
    /// specified CIDR blocks.
    split: ?SplitOperation,
    /// An update operation to modify construct properties.
    update: ?UpdateOperation,

    pub const json_field_names = .{
        .delete = "delete",
        .merge = "merge",
        .split = "split",
        .update = "update",
    };
};
