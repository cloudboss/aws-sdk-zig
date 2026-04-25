/// References a specific atomic statement within a source document, used to
/// link policy elements back to their source material.
pub const AutomatedReasoningPolicyStatementReference = struct {
    /// The unique identifier of the document containing the referenced statement.
    document_id: []const u8,

    /// The unique identifier of the specific atomic statement being referenced.
    statement_id: []const u8,

    pub const json_field_names = .{
        .document_id = "documentId",
        .statement_id = "statementId",
    };
};
