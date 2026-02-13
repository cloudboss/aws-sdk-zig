/// Encloses the `Id` of an entry in `
/// ChangeMessageVisibilityBatch.`
pub const ChangeMessageVisibilityBatchResultEntry = struct {
    /// Represents a message whose visibility timeout has been changed successfully.
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};
