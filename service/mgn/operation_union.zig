const UpdateOperation = @import("update_operation.zig").UpdateOperation;

/// A union type representing the operation to perform on a construct during a
/// mapping update.
pub const OperationUnion = union(enum) {
    /// An update operation to modify construct properties.
    update: ?UpdateOperation,

    pub const json_field_names = .{
        .update = "update",
    };
};
