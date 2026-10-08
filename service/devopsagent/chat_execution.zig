/// A single chat execution summary
pub const ChatExecution = struct {
    /// Timestamp when the chat was created
    created_at: i64,

    /// The unique identifier for the execution
    execution_id: []const u8,

    /// Summary or title of the chat
    summary: ?[]const u8 = null,

    /// Timestamp when the chat was last updated
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .execution_id = "executionId",
        .summary = "summary",
        .updated_at = "updatedAt",
    };
};
