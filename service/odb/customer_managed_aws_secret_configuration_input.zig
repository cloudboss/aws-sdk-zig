const ExternalIdType = @import("external_id_type.zig").ExternalIdType;

/// The input configuration for a customer-managed Amazon Web Services Secrets
/// Manager secret used to supply a password.
pub const CustomerManagedAwsSecretConfigurationInput = struct {
    /// The type of Oracle Cloud Identifier (OCID) used as the external ID when
    /// assuming the IAM role.
    ///
    /// The valid values depend on the operation. For the `CreateAutonomousDatabase`
    /// operation, only `compartment_ocid` and `tenant_ocid` are allowed. For the
    /// `UpdateAutonomousDatabase` and `CreateAutonomousDatabaseWallet` operations,
    /// `database_ocid`, `compartment_ocid`, and `tenant_ocid` are all allowed.
    external_id_type: ?ExternalIdType = null,

    /// The Amazon Resource Name (ARN) of the Amazon Web Services Identity and
    /// Access Management (IAM) role that OCI assumes to retrieve the secret value.
    iam_role_arn: ?[]const u8 = null,

    /// The identifier or ARN of the Amazon Web Services Secrets Manager secret that
    /// contains the password.
    secret_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .external_id_type = "externalIdType",
        .iam_role_arn = "iamRoleArn",
        .secret_id = "secretId",
    };
};
