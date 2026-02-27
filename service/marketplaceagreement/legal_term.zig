const DocumentItem = @import("document_item.zig").DocumentItem;

/// Defines the list of text agreements proposed to the acceptors. An example is
/// the end user license agreement (EULA).
pub const LegalTerm = struct {
    /// List of references to legal resources proposed to the buyers. An example is
    /// the EULA.
    documents: ?[]const DocumentItem,

    /// Category of the term being updated.
    type: ?[]const u8,

    pub const json_field_names = .{
        .documents = "documents",
        .type = "type",
    };
};
