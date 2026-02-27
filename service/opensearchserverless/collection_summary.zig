const CollectionStatus = @import("collection_status.zig").CollectionStatus;

/// Details about each OpenSearch Serverless collection.
pub const CollectionSummary = struct {
    /// The Amazon Resource Name (ARN) of the collection.
    arn: ?[]const u8,

    /// The name of the collection group that contains this collection.
    collection_group_name: ?[]const u8,

    /// The unique identifier of the collection.
    id: ?[]const u8,

    /// The ARN of the Amazon Web Services Key Management Service key used to
    /// encrypt the collection.
    kms_key_arn: ?[]const u8,

    /// The name of the collection.
    name: ?[]const u8,

    /// The current status of the collection.
    status: ?CollectionStatus,

    pub const json_field_names = .{
        .arn = "arn",
        .collection_group_name = "collectionGroupName",
        .id = "id",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .status = "status",
    };
};
