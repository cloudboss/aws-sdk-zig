const std = @import("std");

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

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .opensearch_serverless => "OPENSEARCH_SERVERLESS",
            .pinecone => "PINECONE",
            .redis_enterprise_cloud => "REDIS_ENTERPRISE_CLOUD",
            .rds => "RDS",
            .mongo_db_atlas => "MONGO_DB_ATLAS",
            .neptune_analytics => "NEPTUNE_ANALYTICS",
            .opensearch_managed_cluster => "OPENSEARCH_MANAGED_CLUSTER",
            .s3_vectors => "S3_VECTORS",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
