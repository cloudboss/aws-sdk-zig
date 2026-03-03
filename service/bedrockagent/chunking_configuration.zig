const ChunkingStrategy = @import("chunking_strategy.zig").ChunkingStrategy;
const FixedSizeChunkingConfiguration = @import("fixed_size_chunking_configuration.zig").FixedSizeChunkingConfiguration;
const HierarchicalChunkingConfiguration = @import("hierarchical_chunking_configuration.zig").HierarchicalChunkingConfiguration;
const SemanticChunkingConfiguration = @import("semantic_chunking_configuration.zig").SemanticChunkingConfiguration;

/// Details about how to chunk the documents in the data source. A *chunk*
/// refers to an excerpt from a data source that is returned when the knowledge
/// base that it belongs to is queried.
pub const ChunkingConfiguration = struct {
    /// Knowledge base can split your source data into chunks. A *chunk* refers to
    /// an excerpt from a data source that is returned when the knowledge base that
    /// it belongs to is queried. You have the following options for chunking your
    /// data. If you opt for `NONE`, then you may want to pre-process your files by
    /// splitting them up such that each file corresponds to a chunk.
    ///
    /// * `FIXED_SIZE` – Amazon Bedrock splits your source data into chunks of the
    ///   approximate size that you set in the `fixedSizeChunkingConfiguration`.
    /// * `HIERARCHICAL` – Split documents into layers of chunks where the first
    ///   layer contains large chunks, and the second layer contains smaller chunks
    ///   derived from the first layer.
    /// * `SEMANTIC` – Split documents into chunks based on groups of similar
    ///   content derived with natural language processing.
    /// * `NONE` – Amazon Bedrock treats each file as one chunk. If you choose this
    ///   option, you may want to pre-process your documents by splitting them into
    ///   separate files.
    chunking_strategy: ChunkingStrategy,

    /// Configurations for when you choose fixed-size chunking. If you set the
    /// `chunkingStrategy` as `NONE`, exclude this field.
    fixed_size_chunking_configuration: ?FixedSizeChunkingConfiguration = null,

    /// Settings for hierarchical document chunking for a data source. Hierarchical
    /// chunking splits documents into layers of chunks where the first layer
    /// contains large chunks, and the second layer contains smaller chunks derived
    /// from the first layer.
    hierarchical_chunking_configuration: ?HierarchicalChunkingConfiguration = null,

    /// Settings for semantic document chunking for a data source. Semantic chunking
    /// splits a document into into smaller documents based on groups of similar
    /// content derived from the text with natural language processing.
    semantic_chunking_configuration: ?SemanticChunkingConfiguration = null,

    pub const json_field_names = .{
        .chunking_strategy = "chunkingStrategy",
        .fixed_size_chunking_configuration = "fixedSizeChunkingConfiguration",
        .hierarchical_chunking_configuration = "hierarchicalChunkingConfiguration",
        .semantic_chunking_configuration = "semanticChunkingConfiguration",
    };
};
