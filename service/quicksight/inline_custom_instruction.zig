const UploadedDocumentMetadata = @import("uploaded_document_metadata.zig").UploadedDocumentMetadata;

/// An inline custom instruction with text content and optional file upload
/// metadata.
pub const InlineCustomInstruction = struct {
    /// The instruction text content.
    instruction_text: []const u8,

    /// Metadata about an uploaded document associated with this instruction.
    uploaded_document_metadata: ?UploadedDocumentMetadata = null,

    pub const json_field_names = .{
        .instruction_text = "InstructionText",
        .uploaded_document_metadata = "UploadedDocumentMetadata",
    };
};
