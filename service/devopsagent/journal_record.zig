const UserReference = @import("user_reference.zig").UserReference;

/// Represents a journal record containing execution details and content
pub const JournalRecord = struct {
    /// The unique identifier for the agent space containing this record
    agent_space_id: []const u8,

    /// The content of this journal record
    content: []const u8,

    /// Timestamp when this journal record was created
    created_at: i64,

    /// The execution ID associated with this journal record
    execution_id: []const u8,

    /// The unique identifier for this journal record
    record_id: []const u8,

    /// The type of this journal record
    record_type: []const u8,

    /// Reference to the user associated with this journal record
    user_reference: ?UserReference = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .content = "content",
        .created_at = "createdAt",
        .execution_id = "executionId",
        .record_id = "recordId",
        .record_type = "recordType",
        .user_reference = "userReference",
    };
};
