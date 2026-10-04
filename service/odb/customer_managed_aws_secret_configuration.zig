const ExternalIdType = @import("external_id_type.zig").ExternalIdType;

/// The configuration of a customer-managed Amazon Web Services Secrets Manager
/// secret used to supply a password.
pub const CustomerManagedAwsSecretConfiguration = struct {
    /// The type of Oracle Cloud Identifier (OCID) used as the external ID when
    /// assuming the IAM role.
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
