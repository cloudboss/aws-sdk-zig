pub const KnowledgeBaseStorageType = enum {
    opensearch_serverless,
    pinecone,
    redis_enterprise_cloud,
    rds,
    mongo_db_atlas,
    neptune_analytics,
    opensearch_managed_cluster,
    s3_vectors,

    pub const json_field_names = .{
        .opensearch_serverless = "OPENSEARCH_SERVERLESS",
        .pinecone = "PINECONE",
        .redis_enterprise_cloud = "REDIS_ENTERPRISE_CLOUD",
        .rds = "RDS",
        .mongo_db_atlas = "MONGO_DB_ATLAS",
        .neptune_analytics = "NEPTUNE_ANALYTICS",
        .opensearch_managed_cluster = "OPENSEARCH_MANAGED_CLUSTER",
        .s3_vectors = "S3_VECTORS",
    };
};
