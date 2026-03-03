const StandbyReplicas = @import("standby_replicas.zig").StandbyReplicas;
const CollectionStatus = @import("collection_status.zig").CollectionStatus;
const CollectionType = @import("collection_type.zig").CollectionType;
const VectorOptions = @import("vector_options.zig").VectorOptions;

/// Details about the created OpenSearch Serverless collection.
pub const CreateCollectionDetail = struct {
    /// The Amazon Resource Name (ARN) of the collection.
    arn: ?[]const u8 = null,

    /// The name of the collection group that contains this collection.
    collection_group_name: ?[]const u8 = null,

    /// The Epoch time when the collection was created.
    created_date: ?i64 = null,

    /// A description of the collection.
    description: ?[]const u8 = null,

    /// The unique identifier of the collection.
    id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS key with which to encrypt the
    /// collection.
    kms_key_arn: ?[]const u8 = null,

    /// The date and time when the collection was last modified.
    last_modified_date: ?i64 = null,

    /// The name of the collection.
    name: ?[]const u8 = null,

    /// Creates details about an OpenSearch Serverless collection.
    standby_replicas: ?StandbyReplicas = null,

    /// The current status of the collection.
    status: ?CollectionStatus = null,

    /// The type of collection.
    @"type": ?CollectionType = null,

    /// Configuration options for vector search capabilities in the collection.
    vector_options: ?VectorOptions = null,

    pub const json_field_names = .{
        .arn = "arn",
        .collection_group_name = "collectionGroupName",
        .created_date = "createdDate",
        .description = "description",
        .id = "id",
        .kms_key_arn = "kmsKeyArn",
        .last_modified_date = "lastModifiedDate",
        .name = "name",
        .standby_replicas = "standbyReplicas",
        .status = "status",
        .@"type" = "type",
        .vector_options = "vectorOptions",
    };
};
