/// A general warning message from agentic retrieval.
pub const AgenticRetrieveWarningMessage = struct {
    /// The warning message text.
    message: []const u8,

    pub const json_field_names = .{
        .message = "message",
    };
};
