const DataDeletionPolicy = @import("data_deletion_policy.zig").DataDeletionPolicy;
const DataSourceConfiguration = @import("data_source_configuration.zig").DataSourceConfiguration;
const ServerSideEncryptionConfiguration = @import("server_side_encryption_configuration.zig").ServerSideEncryptionConfiguration;
const DataSourceStatus = @import("data_source_status.zig").DataSourceStatus;
const VectorIngestionConfiguration = @import("vector_ingestion_configuration.zig").VectorIngestionConfiguration;

/// Contains details about a data source.
pub const DataSource = struct {
    /// The time at which the data source was created.
    created_at: i64,

    /// The data deletion policy for the data source.
    data_deletion_policy: ?DataDeletionPolicy = null,

    /// The connection configuration for the data source.
    data_source_configuration: DataSourceConfiguration,

    /// The unique identifier of the data source.
    data_source_id: []const u8,

    /// The description of the data source.
    description: ?[]const u8 = null,

    /// The detailed reasons on the failure to delete a data source.
    failure_reasons: ?[]const []const u8 = null,

    /// The unique identifier of the knowledge base to which the data source
    /// belongs.
    knowledge_base_id: []const u8,

    /// The name of the data source.
    name: []const u8,

    /// Contains details about the configuration of the server-side encryption.
    server_side_encryption_configuration: ?ServerSideEncryptionConfiguration = null,

    /// The status of the data source. The following statuses are possible:
    ///
    /// * Available – The data source has been created and is ready for ingestion
    ///   into the knowledge base.
    /// * Deleting – The data source is being deleted.
    status: DataSourceStatus,

    /// The time at which the data source was last updated.
    updated_at: i64,

    /// Contains details about how to ingest the documents in the data source.
    vector_ingestion_configuration: ?VectorIngestionConfiguration = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .data_deletion_policy = "dataDeletionPolicy",
        .data_source_configuration = "dataSourceConfiguration",
        .data_source_id = "dataSourceId",
        .description = "description",
        .failure_reasons = "failureReasons",
        .knowledge_base_id = "knowledgeBaseId",
        .name = "name",
        .server_side_encryption_configuration = "serverSideEncryptionConfiguration",
        .status = "status",
        .updated_at = "updatedAt",
        .vector_ingestion_configuration = "vectorIngestionConfiguration",
    };
};
