/// Gives a detailed description of the result of an action on each entry in the
/// request.
pub const BatchResultErrorEntry = struct {
    /// An error code representing why the action failed on this entry.
    code: []const u8,

    /// The `Id` of an entry in a batch request.
    id: []const u8,

    /// A message explaining why the action failed on this entry.
    message: ?[]const u8 = null,

    /// Specifies whether the error happened due to the caller of the batch API
    /// action.
    sender_fault: bool = false,

    pub const json_field_names = .{
        .code = "Code",
        .id = "Id",
        .message = "Message",
        .sender_fault = "SenderFault",
    };
};
