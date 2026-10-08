/// Contains summary information about a code review.
pub const CodeReviewSummary = struct {
    /// The unique identifier of the agent space that contains the code review.
    agent_space_id: []const u8,

    /// The unique identifier of the code review.
    code_review_id: []const u8,

    /// The date and time the code review was created, in UTC format.
    created_at: ?i64 = null,

    /// The title of the code review.
    title: []const u8,

    /// The date and time the code review was last updated, in UTC format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .agent_space_id = "agentSpaceId",
        .code_review_id = "codeReviewId",
        .created_at = "createdAt",
        .title = "title",
        .updated_at = "updatedAt",
    };
};
