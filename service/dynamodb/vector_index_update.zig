const CreateVectorIndexAction = @import("create_vector_index_action.zig").CreateVectorIndexAction;
const DeleteVectorIndexAction = @import("delete_vector_index_action.zig").DeleteVectorIndexAction;

/// A vector index to be added to or removed from a table.
pub const VectorIndexUpdate = struct {
    /// The configuration for creating a new vector index on the table.
    create: ?CreateVectorIndexAction = null,

    /// The configuration for deleting an existing vector index from the table.
    delete: ?DeleteVectorIndexAction = null,

    pub const json_field_names = .{
        .create = "Create",
        .delete = "Delete",
    };
};
