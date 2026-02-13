/// Operational metadata for an application in Application Manager.
pub const OpsMetadata = struct {
    /// The date the OpsMetadata objects was created.
    creation_date: ?i64,

    /// The date the OpsMetadata object was last updated.
    last_modified_date: ?i64,

    /// The user name who last updated the OpsMetadata object.
    last_modified_user: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the OpsMetadata Object or blob.
    ops_metadata_arn: ?[]const u8,

    /// The ID of the Application Manager application.
    resource_id: ?[]const u8,

    pub const json_field_names = .{
        .creation_date = "CreationDate",
        .last_modified_date = "LastModifiedDate",
        .last_modified_user = "LastModifiedUser",
        .ops_metadata_arn = "OpsMetadataArn",
        .resource_id = "ResourceId",
    };
};
