/// The IAM properties of a connection.
pub const IamPropertiesInput = struct {
    /// Specifies whether Amazon Web Services Glue lineage sync is enabled for a
    /// connection.
    glue_lineage_sync_enabled: ?bool = null,

    /// The ARN of the IAM role to associate with the connection as the project user
    /// role. To use this operation, you must have `iam:PassRole` permission for
    /// this role.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .glue_lineage_sync_enabled = "glueLineageSyncEnabled",
        .role_arn = "roleArn",
    };
};
