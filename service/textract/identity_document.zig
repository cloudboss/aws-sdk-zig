const Block = @import("block.zig").Block;
const IdentityDocumentField = @import("identity_document_field.zig").IdentityDocumentField;

/// The structure that lists each document processed in an AnalyzeID operation.
pub const IdentityDocument = struct {
    /// Individual word recognition, as returned by document detection.
    blocks: ?[]const Block = null,

    /// Denotes the placement of a document in the IdentityDocument list. The first
    /// document
    /// is marked 1, the second 2 and so on.
    document_index: ?i32 = null,

    /// The structure used to record information extracted from identity documents.
    /// Contains both normalized field and value of the extracted text.
    identity_document_fields: ?[]const IdentityDocumentField = null,

    pub const json_field_names = .{
        .blocks = "Blocks",
        .document_index = "DocumentIndex",
        .identity_document_fields = "IdentityDocumentFields",
    };
};
