/// A failure that occurred during agentic retrieval.
pub const AgenticRetrieveFailure = struct {
    /// A message describing the failure.
    message: []const u8,

    pub const json_field_names = .{
        .message = "message",
    };
};
