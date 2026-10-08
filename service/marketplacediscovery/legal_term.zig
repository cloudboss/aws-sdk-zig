const DocumentItem = @import("document_item.zig").DocumentItem;
const TermType = @import("term_type.zig").TermType;

/// Defines a legal term containing documents proposed to buyers, such as EULAs
/// and data subscription agreements.
pub const LegalTerm = struct {
    /// The legal documents proposed to the buyer as part of this term.
    documents: []const DocumentItem,

    /// The unique identifier of the term.
    id: []const u8,

    /// The category of the term.
    type: TermType,

    pub const json_field_names = .{
        .documents = "documents",
        .id = "id",
        .type = "type",
    };
};
