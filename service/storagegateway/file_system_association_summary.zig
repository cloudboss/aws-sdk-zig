/// Gets the summary returned by `ListFileSystemAssociation`, which is a summary
/// of a created file system association.
pub const FileSystemAssociationSummary = struct {
    /// The Amazon Resource Name (ARN) of the file system association.
    file_system_association_arn: ?[]const u8 = null,

    /// The ID of the file system association.
    file_system_association_id: ?[]const u8 = null,

    /// The status of the file share. Valid Values: `AVAILABLE` |
    /// `CREATING` | `DELETING` | `FORCE_DELETING` |
    /// `UPDATING` | `ERROR`
    file_system_association_status: ?[]const u8 = null,

    gateway_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_system_association_arn = "FileSystemAssociationARN",
        .file_system_association_id = "FileSystemAssociationId",
        .file_system_association_status = "FileSystemAssociationStatus",
        .gateway_arn = "GatewayARN",
    };
};
