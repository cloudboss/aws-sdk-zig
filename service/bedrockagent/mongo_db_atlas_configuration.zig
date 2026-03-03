const MongoDbAtlasFieldMapping = @import("mongo_db_atlas_field_mapping.zig").MongoDbAtlasFieldMapping;

/// Contains details about the storage configuration of the knowledge base in
/// MongoDB Atlas.
pub const MongoDbAtlasConfiguration = struct {
    /// The collection name of the knowledge base in MongoDB Atlas.
    collection_name: []const u8,

    /// The Amazon Resource Name (ARN) of the secret that you created in Secrets
    /// Manager that contains user credentials for your MongoDB Atlas cluster.
    credentials_secret_arn: []const u8,

    /// The database name in your MongoDB Atlas cluster for your knowledge base.
    database_name: []const u8,

    /// The endpoint URL of your MongoDB Atlas cluster for your knowledge base.
    endpoint: []const u8,

    /// The name of the VPC endpoint service in your account that is connected to
    /// your MongoDB Atlas cluster.
    endpoint_service_name: ?[]const u8 = null,

    /// Contains the names of the fields to which to map information about the
    /// vector store.
    field_mapping: MongoDbAtlasFieldMapping,

    /// The name of the text search index in the MongoDB collection. This is
    /// required for using the hybrid search feature.
    text_index_name: ?[]const u8 = null,

    /// The name of the MongoDB Atlas vector search index.
    vector_index_name: []const u8,

    pub const json_field_names = .{
        .collection_name = "collectionName",
        .credentials_secret_arn = "credentialsSecretArn",
        .database_name = "databaseName",
        .endpoint = "endpoint",
        .endpoint_service_name = "endpointServiceName",
        .field_mapping = "fieldMapping",
        .text_index_name = "textIndexName",
        .vector_index_name = "vectorIndexName",
    };
};
