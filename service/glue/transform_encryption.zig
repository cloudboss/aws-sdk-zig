const MLUserDataEncryption = @import("ml_user_data_encryption.zig").MLUserDataEncryption;

/// The encryption-at-rest settings of the transform that apply to accessing
/// user data. Machine learning transforms can access user data encrypted in
/// Amazon S3 using KMS.
///
/// Additionally, imported labels and trained transforms can now be encrypted
/// using a customer provided KMS key.
pub const TransformEncryption = struct {
    /// An `MLUserDataEncryption` object containing the encryption mode and
    /// customer-provided KMS key ID.
    ml_user_data_encryption: ?MLUserDataEncryption,

    /// The name of the security configuration.
    task_run_security_configuration_name: ?[]const u8,

    pub const json_field_names = .{
        .ml_user_data_encryption = "MlUserDataEncryption",
        .task_run_security_configuration_name = "TaskRunSecurityConfigurationName",
    };
};
