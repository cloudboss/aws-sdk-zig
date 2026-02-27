/// Attributes that define a secret resource, which references a secret from AWS
/// Secrets Manager. AWS IoT Greengrass stores a local, encrypted copy of the
/// secret on the Greengrass core, where it can be securely accessed by
/// connectors and Lambda functions.
pub const SecretsManagerSecretResourceData = struct {
    /// Optional. The staging labels whose values you want to make available on the
    /// core, in addition to ''AWSCURRENT''.
    additional_staging_labels_to_download: ?[]const []const u8,

    /// The ARN of the Secrets Manager secret to make available on the core. The
    /// value of the secret's latest version (represented by the ''AWSCURRENT''
    /// staging label) is included by default.
    arn: ?[]const u8,

    pub const json_field_names = .{
        .additional_staging_labels_to_download = "AdditionalStagingLabelsToDownload",
        .arn = "ARN",
    };
};
