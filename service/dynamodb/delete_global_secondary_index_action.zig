/// Represents a global secondary index to be deleted from an existing table.
pub const DeleteGlobalSecondaryIndexAction = struct {
    /// The name of the global secondary index to be deleted.
    index_name: []const u8,
};
