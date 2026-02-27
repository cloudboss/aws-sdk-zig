/// Contains information about an alias.
pub const AliasListEntry = struct {
    /// String that contains the key ARN.
    alias_arn: ?[]const u8,

    /// String that contains the alias. This value begins with `alias/`.
    alias_name: ?[]const u8,

    /// Date and time that the alias was most recently created in the account and
    /// Region.
    /// Formatted as Unix time.
    creation_date: ?i64,

    /// Date and time that the alias was most recently associated with a KMS key in
    /// the account
    /// and Region. Formatted as Unix time.
    last_updated_date: ?i64,

    /// String that contains the key identifier of the KMS key associated with the
    /// alias.
    target_key_id: ?[]const u8,

    pub const json_field_names = .{
        .alias_arn = "AliasArn",
        .alias_name = "AliasName",
        .creation_date = "CreationDate",
        .last_updated_date = "LastUpdatedDate",
        .target_key_id = "TargetKeyId",
    };
};
