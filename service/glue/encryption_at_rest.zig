const CatalogEncryptionMode = @import("catalog_encryption_mode.zig").CatalogEncryptionMode;

/// Specifies the encryption-at-rest configuration for the Data Catalog.
pub const EncryptionAtRest = struct {
    /// The encryption-at-rest mode for encrypting Data Catalog data.
    catalog_encryption_mode: CatalogEncryptionMode,

    /// The role that Glue assumes to encrypt and decrypt the Data Catalog objects
    /// on the caller's behalf.
    catalog_encryption_service_role: ?[]const u8 = null,

    /// The ID of the KMS key to use for encryption at rest.
    sse_aws_kms_key_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .catalog_encryption_mode = "CatalogEncryptionMode",
        .catalog_encryption_service_role = "CatalogEncryptionServiceRole",
        .sse_aws_kms_key_id = "SseAwsKmsKeyId",
    };
};
