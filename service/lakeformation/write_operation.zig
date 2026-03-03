const AddObjectInput = @import("add_object_input.zig").AddObjectInput;
const DeleteObjectInput = @import("delete_object_input.zig").DeleteObjectInput;

/// Defines an object to add to or delete from a governed table.
pub const WriteOperation = struct {
    /// A new object to add to the governed table.
    add_object: ?AddObjectInput = null,

    /// An object to delete from the governed table.
    delete_object: ?DeleteObjectInput = null,

    pub const json_field_names = .{
        .add_object = "AddObject",
        .delete_object = "DeleteObject",
    };
};
