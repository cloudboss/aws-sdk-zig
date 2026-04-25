const AutomatedReasoningPolicyBuildDocumentContentType = @import("automated_reasoning_policy_build_document_content_type.zig").AutomatedReasoningPolicyBuildDocumentContentType;

/// Represents a source document that was processed during a build workflow.
/// Contains the document content, metadata, and a hash for verification.
pub const AutomatedReasoningPolicySourceDocument = struct {
    /// The raw content of the source document as a binary blob.
    document: []const u8,

    /// The MIME type of the document (e.g., application/pdf, text/plain).
    document_content_type: AutomatedReasoningPolicyBuildDocumentContentType,

    /// An optional description providing context about the document's content and
    /// purpose.
    document_description: ?[]const u8 = null,

    /// A SHA-256 hash of the document content, used for verification and integrity
    /// checking.
    document_hash: []const u8,

    /// The name of the source document for identification purposes.
    document_name: []const u8,

    pub const json_field_names = .{
        .document = "document",
        .document_content_type = "documentContentType",
        .document_description = "documentDescription",
        .document_hash = "documentHash",
        .document_name = "documentName",
    };
};
