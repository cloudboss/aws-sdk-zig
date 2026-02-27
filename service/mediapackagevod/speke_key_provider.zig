const EncryptionContractConfiguration = @import("encryption_contract_configuration.zig").EncryptionContractConfiguration;

/// A configuration for accessing an external Secure Packager and Encoder Key
/// Exchange (SPEKE) service that will provide encryption keys.
pub const SpekeKeyProvider = struct {
    encryption_contract_configuration: ?EncryptionContractConfiguration,

    /// An Amazon Resource Name (ARN) of an IAM role that AWS Elemental
    /// MediaPackage will assume when accessing the key provider service.
    role_arn: []const u8,

    /// The system IDs to include in key requests.
    system_ids: []const []const u8,

    /// The URL of the external key provider service.
    url: []const u8,

    pub const json_field_names = .{
        .encryption_contract_configuration = "EncryptionContractConfiguration",
        .role_arn = "RoleArn",
        .system_ids = "SystemIds",
        .url = "Url",
    };
};
