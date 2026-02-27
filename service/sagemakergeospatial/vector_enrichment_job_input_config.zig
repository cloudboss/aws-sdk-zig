const VectorEnrichmentJobDataSourceConfigInput = @import("vector_enrichment_job_data_source_config_input.zig").VectorEnrichmentJobDataSourceConfigInput;
const VectorEnrichmentJobDocumentType = @import("vector_enrichment_job_document_type.zig").VectorEnrichmentJobDocumentType;

/// The input structure for the InputConfig in a VectorEnrichmentJob.
pub const VectorEnrichmentJobInputConfig = struct {
    /// The input structure for the data source that represents the storage type of
    /// the input data objects.
    data_source_config: VectorEnrichmentJobDataSourceConfigInput,

    /// The input structure that defines the data source file type.
    document_type: VectorEnrichmentJobDocumentType,

    pub const json_field_names = .{
        .data_source_config = "DataSourceConfig",
        .document_type = "DocumentType",
    };
};
