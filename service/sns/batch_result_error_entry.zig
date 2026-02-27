/// Gives a detailed description of failed messages in the batch.
pub const BatchResultErrorEntry = struct {
    /// An error code representing why the action failed on this entry.
    code: []const u8,

    /// The `Id` of an entry in a batch request
    id: []const u8,

    /// A message explaining why the action failed on this entry.
    message: ?[]const u8,

    /// Specifies whether the error happened due to the caller of the batch API
    /// action.
    sender_fault: bool = false,
};
