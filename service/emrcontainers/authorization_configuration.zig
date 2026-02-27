const EncryptionConfiguration = @import("encryption_configuration.zig").EncryptionConfiguration;
const LakeFormationConfiguration = @import("lake_formation_configuration.zig").LakeFormationConfiguration;

/// Authorization-related configuration inputs for the security configuration.
pub const AuthorizationConfiguration = struct {
    /// Encryption-related configuration input for the security configuration.
    encryption_configuration: ?EncryptionConfiguration,

    /// Lake Formation related configuration inputs for the security
    /// configuration.
    lake_formation_configuration: ?LakeFormationConfiguration,

    pub const json_field_names = .{
        .encryption_configuration = "encryptionConfiguration",
        .lake_formation_configuration = "lakeFormationConfiguration",
    };
};
