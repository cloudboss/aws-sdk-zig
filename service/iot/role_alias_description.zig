/// Role alias description.
pub const RoleAliasDescription = struct {
    /// The UNIX timestamp of when the role alias was created.
    creation_date: ?i64 = null,

    /// The number of seconds for which the credential is valid.
    credential_duration_seconds: ?i32 = null,

    /// The UNIX timestamp of when the role alias was last modified.
    last_modified_date: ?i64 = null,

    /// The role alias owner.
    owner: ?[]const u8 = null,

    /// The role alias.
    role_alias: ?[]const u8 = null,

    /// The ARN of the role alias.
    role_alias_arn: ?[]const u8 = null,

    /// The role ARN.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .credential_duration_seconds = "credentialDurationSeconds",
        .last_modified_date = "lastModifiedDate",
        .owner = "owner",
        .role_alias = "roleAlias",
        .role_alias_arn = "roleAliasArn",
        .role_arn = "roleArn",
    };
};
