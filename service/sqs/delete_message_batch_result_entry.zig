/// Encloses the `Id` of an entry in `
/// DeleteMessageBatch.`
pub const DeleteMessageBatchResultEntry = struct {
    /// Represents a successfully deleted message.
    id: []const u8,

    pub const json_field_names = .{
        .id = "Id",
    };
};
