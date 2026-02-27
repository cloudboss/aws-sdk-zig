const MemorySessionSummary = @import("memory_session_summary.zig").MemorySessionSummary;

/// Contains sessions summaries.
pub const Memory = union(enum) {
    /// Contains summary of a session.
    session_summary: ?MemorySessionSummary,

    pub const json_field_names = .{
        .session_summary = "sessionSummary",
    };
};
