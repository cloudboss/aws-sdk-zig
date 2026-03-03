const MongoDbAtlasConfiguration = @import("mongo_db_atlas_configuration.zig").MongoDbAtlasConfiguration;
const NeptuneAnalyticsConfiguration = @import("neptune_analytics_configuration.zig").NeptuneAnalyticsConfiguration;
const OpenSearchManagedClusterConfiguration = @import("open_search_managed_cluster_configuration.zig").OpenSearchManagedClusterConfiguration;
const OpenSearchServerlessConfiguration = @import("open_search_serverless_configuration.zig").OpenSearchServerlessConfiguration;
const PineconeConfiguration = @import("pinecone_configuration.zig").PineconeConfiguration;
const RdsConfiguration = @import("rds_configuration.zig").RdsConfiguration;
const RedisEnterpriseCloudConfiguration = @import("redis_enterprise_cloud_configuration.zig").RedisEnterpriseCloudConfiguration;
const S3VectorsConfiguration = @import("s3_vectors_configuration.zig").S3VectorsConfiguration;
const KnowledgeBaseStorageType = @import("knowledge_base_storage_type.zig").KnowledgeBaseStorageType;

/// Contains the storage configuration of the knowledge base.
pub const StorageConfiguration = struct {
    /// Contains the storage configuration of the knowledge base in MongoDB Atlas.
    mongo_db_atlas_configuration: ?MongoDbAtlasConfiguration = null,

    /// Contains details about the Neptune Analytics configuration of the knowledge
    /// base in Amazon Neptune. For more information, see [Create a vector index in
    /// Amazon Neptune
    /// Analytics.](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-setup-neptune.html).
    neptune_analytics_configuration: ?NeptuneAnalyticsConfiguration = null,

    /// Contains details about the storage configuration of the knowledge base in
    /// OpenSearch Managed Cluster. For more information, see [Create a vector index
    /// in Amazon OpenSearch
    /// Service](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-setup-osm.html).
    opensearch_managed_cluster_configuration: ?OpenSearchManagedClusterConfiguration = null,

    /// Contains the storage configuration of the knowledge base in Amazon
    /// OpenSearch Service.
    opensearch_serverless_configuration: ?OpenSearchServerlessConfiguration = null,

    /// Contains the storage configuration of the knowledge base in Pinecone.
    pinecone_configuration: ?PineconeConfiguration = null,

    /// Contains details about the storage configuration of the knowledge base in
    /// Amazon RDS. For more information, see [Create a vector index in Amazon
    /// RDS](https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-setup-rds.html).
    rds_configuration: ?RdsConfiguration = null,

    /// Contains the storage configuration of the knowledge base in Redis Enterprise
    /// Cloud.
    redis_enterprise_cloud_configuration: ?RedisEnterpriseCloudConfiguration = null,

    /// The configuration settings for storing knowledge base data using S3 vectors.
    /// This includes vector index information and S3 bucket details for vector
    /// storage.
    s_3_vectors_configuration: ?S3VectorsConfiguration = null,

    /// The vector store service in which the knowledge base is stored.
    @"type": KnowledgeBaseStorageType,

    pub const json_field_names = .{
        .mongo_db_atlas_configuration = "mongoDbAtlasConfiguration",
        .neptune_analytics_configuration = "neptuneAnalyticsConfiguration",
        .opensearch_managed_cluster_configuration = "opensearchManagedClusterConfiguration",
        .opensearch_serverless_configuration = "opensearchServerlessConfiguration",
        .pinecone_configuration = "pineconeConfiguration",
        .rds_configuration = "rdsConfiguration",
        .redis_enterprise_cloud_configuration = "redisEnterpriseCloudConfiguration",
        .s_3_vectors_configuration = "s3VectorsConfiguration",
        .@"type" = "type",
    };
};
