/// These are the items returned in the results of a search of Amazon S3 backup
/// metadata.
pub const S3ResultItem = struct {
    /// These are items in the returned results that match recovery point Amazon
    /// Resource Names (ARN) input during a search of Amazon S3 backup metadata.
    backup_resource_arn: ?[]const u8 = null,

    /// The name of the backup vault.
    backup_vault_name: ?[]const u8 = null,

    /// These are one or more items in the returned results that match values for
    /// item creation time input during a search of Amazon S3 backup metadata.
    creation_time: ?i64 = null,

    /// These are one or more items in the returned results that match values for
    /// ETags input during a search of Amazon S3 backup metadata.
    e_tag: ?[]const u8 = null,

    /// This is one or more items returned in the results of a search of Amazon S3
    /// backup metadata that match the values input for object key.
    object_key: ?[]const u8 = null,

    /// These are items in the returned results that match values for object size(s)
    /// input during a search of Amazon S3 backup metadata.
    object_size: ?i64 = null,

    /// These are items in the returned results that match source Amazon Resource
    /// Names (ARN) input during a search of Amazon S3 backup metadata.
    source_resource_arn: ?[]const u8 = null,

    /// These are one or more items in the returned results that match values for
    /// version IDs input during a search of Amazon S3 backup metadata.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .backup_resource_arn = "BackupResourceArn",
        .backup_vault_name = "BackupVaultName",
        .creation_time = "CreationTime",
        .e_tag = "ETag",
        .object_key = "ObjectKey",
        .object_size = "ObjectSize",
        .source_resource_arn = "SourceResourceArn",
        .version_id = "VersionId",
    };
};
