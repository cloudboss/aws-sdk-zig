const ChunkingConfiguration = @import("chunking_configuration.zig").ChunkingConfiguration;
const ContextEnrichmentConfiguration = @import("context_enrichment_configuration.zig").ContextEnrichmentConfiguration;
const CustomTransformationConfiguration = @import("custom_transformation_configuration.zig").CustomTransformationConfiguration;
const ParsingConfiguration = @import("parsing_configuration.zig").ParsingConfiguration;

/// Contains details about how to ingest the documents in a data source.
pub const VectorIngestionConfiguration = struct {
    /// Details about how to chunk the documents in the data source. A *chunk*
    /// refers to an excerpt from a data source that is returned when the knowledge
    /// base that it belongs to is queried.
    chunking_configuration: ?ChunkingConfiguration = null,

    /// The context enrichment configuration used for ingestion of the data into the
    /// vector store.
    context_enrichment_configuration: ?ContextEnrichmentConfiguration = null,

    /// A custom document transformer for parsed data source documents.
    custom_transformation_configuration: ?CustomTransformationConfiguration = null,

    /// Configurations for a parser to use for parsing documents in your data
    /// source. If you exclude this field, the default parser will be used.
    parsing_configuration: ?ParsingConfiguration = null,

    pub const json_field_names = .{
        .chunking_configuration = "chunkingConfiguration",
        .context_enrichment_configuration = "contextEnrichmentConfiguration",
        .custom_transformation_configuration = "customTransformationConfiguration",
        .parsing_configuration = "parsingConfiguration",
    };
};
