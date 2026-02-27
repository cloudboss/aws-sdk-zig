const Metadata = @import("metadata.zig").Metadata;
const RetrievedReference = @import("retrieved_reference.zig").RetrievedReference;

/// Contains details about the results from looking up the knowledge base.
pub const KnowledgeBaseLookupOutput = struct {
    /// Contains information about the knowledge base output.
    metadata: ?Metadata,

    /// Contains metadata about the sources cited for the generated response.
    retrieved_references: ?[]const RetrievedReference,

    pub const json_field_names = .{
        .metadata = "metadata",
        .retrieved_references = "retrievedReferences",
    };
};
