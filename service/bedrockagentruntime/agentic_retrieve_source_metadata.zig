const AgenticRetrieveType = @import("agentic_retrieve_type.zig").AgenticRetrieveType;

/// Metadata about a retrieval source.
pub const AgenticRetrieveSourceMetadata = struct {
    /// The identifier of the retrieval source.
    identifier: ?[]const u8 = null,

    /// The type of retrieval source.
    retrieval_type: ?AgenticRetrieveType = null,

    pub const json_field_names = .{
        .identifier = "identifier",
        .retrieval_type = "retrievalType",
    };
};
