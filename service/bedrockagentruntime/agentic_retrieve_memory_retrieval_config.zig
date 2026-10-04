const AgenticRetrieveMemoryMetadataFilter = @import("agentic_retrieve_memory_metadata_filter.zig").AgenticRetrieveMemoryMetadataFilter;

/// The long-term memory namespace that the agent might retrieve memory records
/// from, and the filters applied to that retrieval. You must specify either
/// namespace or namespacePath.
pub const AgenticRetrieveMemoryRetrievalConfig = struct {
    /// The metadata filter expressions that restrict retrieval to matching memory
    /// records. You can specify a maximum of 5 expressions.
    metadata_filters: ?[]const AgenticRetrieveMemoryMetadataFilter = null,

    /// The namespace prefix to filter memory records by. The agent retrieves memory
    /// records in namespaces that start with the provided prefix. You must specify
    /// either namespace or namespacePath.
    namespace: ?[]const u8 = null,

    /// The parent namespace to use for hierarchical retrievals. The agent retrieves
    /// all memory records whose namespace falls under the same parent hierarchy.
    /// You must specify either namespace or namespacePath.
    namespace_path: ?[]const u8 = null,

    /// The extraction strategy ID that restricts retrieval to memory records
    /// produced by a single strategy. Omit this parameter to retrieve records from
    /// every strategy on the memory resource.
    strategy_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .metadata_filters = "metadataFilters",
        .namespace = "namespace",
        .namespace_path = "namespacePath",
        .strategy_id = "strategyId",
    };
};
