/// The object representing the passwords that were used to encrypt the
/// data related to the bot recommendation, as well as the KMS key ARN used
/// to encrypt the associated metadata.
pub const EncryptionSetting = struct {
    /// The password used to encrypt the associated transcript file.
    associated_transcripts_password: ?[]const u8,

    /// The password used to encrypt the recommended bot recommendation
    /// file.
    bot_locale_export_password: ?[]const u8,

    /// The KMS key ARN used to encrypt the metadata associated with the bot
    /// recommendation.
    kms_key_arn: ?[]const u8,

    pub const json_field_names = .{
        .associated_transcripts_password = "associatedTranscriptsPassword",
        .bot_locale_export_password = "botLocaleExportPassword",
        .kms_key_arn = "kmsKeyArn",
    };
};
