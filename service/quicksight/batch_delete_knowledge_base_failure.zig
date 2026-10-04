/// Information about a knowledge base that failed to be deleted in a batch
/// operation.
pub const BatchDeleteKnowledgeBaseFailure = struct {
    /// The error code for the deletion failure.
    error_code: []const u8,

    /// The error message for the deletion failure.
    error_message: []const u8,

    /// The unique identifier of the knowledge base that failed to be deleted.
    knowledge_base_id: []const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
        .knowledge_base_id = "KnowledgeBaseId",
    };
};
