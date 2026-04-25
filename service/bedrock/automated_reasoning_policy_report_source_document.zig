const AutomatedReasoningPolicyAtomicStatement = @import("automated_reasoning_policy_atomic_statement.zig").AutomatedReasoningPolicyAtomicStatement;
const AutomatedReasoningPolicyAnnotatedChunk = @import("automated_reasoning_policy_annotated_chunk.zig").AutomatedReasoningPolicyAnnotatedChunk;

/// Represents a source document that was analyzed during fidelity report
/// generation, including the document's metadata and its content broken down
/// into atomic statements.
pub const AutomatedReasoningPolicyReportSourceDocument = struct {
    /// The list of atomic statements extracted from this document, representing the
    /// fundamental units of meaning used for grounding.
    atomic_statements: []const AutomatedReasoningPolicyAtomicStatement,

    /// The document's content organized into annotated chunks with line number
    /// information for precise referencing.
    document_content: []const AutomatedReasoningPolicyAnnotatedChunk,

    /// A SHA-256 hash of the document content, used for verification and ensuring
    /// the document hasn't changed since analysis.
    document_hash: []const u8,

    /// A unique identifier for this document within the fidelity report.
    document_id: []const u8,

    /// The name of the source document that was analyzed.
    document_name: []const u8,

    pub const json_field_names = .{
        .atomic_statements = "atomicStatements",
        .document_content = "documentContent",
        .document_hash = "documentHash",
        .document_id = "documentId",
        .document_name = "documentName",
    };
};
