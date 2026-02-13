/// A structure that contains information about one version of a secret.
pub const SecretVersionsListEntry = struct {
    /// The date and time this version of the secret was created.
    created_date: ?i64,

    /// The KMS keys used to encrypt the secret version.
    kms_key_ids: ?[]const []const u8,

    /// The date that this version of the secret was last accessed. Note that the
    /// resolution
    /// of this field is at the date level and does not include the time.
    last_accessed_date: ?i64,

    /// The unique version identifier of this version of the secret.
    version_id: ?[]const u8,

    /// An array of staging labels that are currently associated with this version
    /// of the
    /// secret.
    version_stages: ?[]const []const u8,

    pub const json_field_names = .{
        .created_date = "CreatedDate",
        .kms_key_ids = "KmsKeyIds",
        .last_accessed_date = "LastAccessedDate",
        .version_id = "VersionId",
        .version_stages = "VersionStages",
    };
};
