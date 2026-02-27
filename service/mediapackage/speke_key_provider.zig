const EncryptionContractConfiguration = @import("encryption_contract_configuration.zig").EncryptionContractConfiguration;

/// A configuration for accessing an external Secure Packager and Encoder Key
/// Exchange (SPEKE) service that will provide encryption keys.
pub const SpekeKeyProvider = struct {
    /// An Amazon Resource Name (ARN) of a Certificate Manager certificate
    /// that MediaPackage will use for enforcing secure end-to-end data
    /// transfer with the key provider service.
    certificate_arn: ?[]const u8,

    encryption_contract_configuration: ?EncryptionContractConfiguration,

    /// The resource ID to include in key requests.
    resource_id: []const u8,

    /// An Amazon Resource Name (ARN) of an IAM role that AWS Elemental
    /// MediaPackage will assume when accessing the key provider service.
    role_arn: []const u8,

    /// The system IDs to include in key requests.
    system_ids: []const []const u8,

    /// The URL of the external key provider service.
    url: []const u8,

    pub const json_field_names = .{
        .certificate_arn = "CertificateArn",
        .encryption_contract_configuration = "EncryptionContractConfiguration",
        .resource_id = "ResourceId",
        .role_arn = "RoleArn",
        .system_ids = "SystemIds",
        .url = "Url",
    };
};
