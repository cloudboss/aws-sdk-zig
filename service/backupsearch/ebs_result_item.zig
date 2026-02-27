/// These are the items returned in the results of a search of Amazon EBS backup
/// metadata.
pub const EBSResultItem = struct {
    /// These are one or more items in the results that match values for the Amazon
    /// Resource Name (ARN) of recovery points returned in a search of Amazon EBS
    /// backup metadata.
    backup_resource_arn: ?[]const u8,

    /// The name of the backup vault.
    backup_vault_name: ?[]const u8,

    /// These are one or more items in the results that match values for creation
    /// times returned in a search of Amazon EBS backup metadata.
    creation_time: ?i64,

    /// These are one or more items in the results that match values for file paths
    /// returned in a search of Amazon EBS backup metadata.
    file_path: ?[]const u8,

    /// These are one or more items in the results that match values for file sizes
    /// returned in a search of Amazon EBS backup metadata.
    file_size: ?i64,

    /// These are one or more items in the results that match values for file
    /// systems returned in a search of Amazon EBS backup metadata.
    file_system_identifier: ?[]const u8,

    /// These are one or more items in the results that match values for Last
    /// Modified Time returned in a search of Amazon EBS backup metadata.
    last_modified_time: ?i64,

    /// These are one or more items in the results that match values for the Amazon
    /// Resource Name (ARN) of source resources returned in a search of Amazon EBS
    /// backup metadata.
    source_resource_arn: ?[]const u8,

    pub const json_field_names = .{
        .backup_resource_arn = "BackupResourceArn",
        .backup_vault_name = "BackupVaultName",
        .creation_time = "CreationTime",
        .file_path = "FilePath",
        .file_size = "FileSize",
        .file_system_identifier = "FileSystemIdentifier",
        .last_modified_time = "LastModifiedTime",
        .source_resource_arn = "SourceResourceArn",
    };
};
