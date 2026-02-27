const StandbyReplicas = @import("standby_replicas.zig").StandbyReplicas;
const CollectionStatus = @import("collection_status.zig").CollectionStatus;
const CollectionType = @import("collection_type.zig").CollectionType;
const VectorOptions = @import("vector_options.zig").VectorOptions;

/// Details about the created OpenSearch Serverless collection.
pub const CreateCollectionDetail = struct {
    /// The Amazon Resource Name (ARN) of the collection.
    arn: ?[]const u8,

    /// The name of the collection group that contains this collection.
    collection_group_name: ?[]const u8,

    /// The Epoch time when the collection was created.
    created_date: ?i64,

    /// A description of the collection.
    description: ?[]const u8,

    /// The unique identifier of the collection.
    id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the KMS key with which to encrypt the
    /// collection.
    kms_key_arn: ?[]const u8,

    /// The date and time when the collection was last modified.
    last_modified_date: ?i64,

    /// The name of the collection.
    name: ?[]const u8,

    /// Creates details about an OpenSearch Serverless collection.
    standby_replicas: ?StandbyReplicas,

    /// The current status of the collection.
    status: ?CollectionStatus,

    /// The type of collection.
    type: ?CollectionType,

    /// Configuration options for vector search capabilities in the collection.
    vector_options: ?VectorOptions,

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
        .type = "type",
        .vector_options = "vectorOptions",
    };
};
