const AutomatedReasoningPolicyBuildDocumentContentType = @import("automated_reasoning_policy_build_document_content_type.zig").AutomatedReasoningPolicyBuildDocumentContentType;

/// Represents a source document used in the policy build workflow, containing
/// the content and metadata needed for policy generation.
pub const AutomatedReasoningPolicyBuildWorkflowDocument = struct {
    /// The actual content of the source document that will be analyzed to extract
    /// policy rules and concepts.
    document: []const u8,

    /// The MIME type of the document content (e.g., text/plain, application/pdf,
    /// text/markdown).
    document_content_type: AutomatedReasoningPolicyBuildDocumentContentType,

    /// A detailed description of the document's content and how it should be used
    /// in the policy generation process.
    document_description: ?[]const u8,

    /// A descriptive name for the document that helps identify its purpose and
    /// content.
    document_name: []const u8,

    pub const json_field_names = .{
        .document = "document",
        .document_content_type = "documentContentType",
        .document_description = "documentDescription",
        .document_name = "documentName",
    };
};
