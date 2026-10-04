/// A vector index to be removed from a table.
pub const DeleteVectorIndexAction = struct {
    /// The name of the vector index to delete.
    index_name: []const u8,

    pub const json_field_names = .{
        .index_name = "IndexName",
    };
};
