/// A managed secret that contains the credentials for installing vCenter
/// Server, NSX, and SDDC Manager. During environment creation, the Amazon EVS
/// control plane uses Amazon Web Services Secrets Manager to create, encrypt,
/// validate, and store secrets. If you choose to delete your environment,
/// Amazon EVS also deletes the secrets that are associated with your
/// environment. Amazon EVS does not provide managed rotation of secrets. We
/// recommend that you rotate secrets regularly to ensure that secrets are not
/// long-lived.
pub const Secret = struct {
    /// The Amazon Resource Name (ARN) of the secret.
    secret_arn: ?[]const u8,

    pub const json_field_names = .{
        .secret_arn = "secretArn",
    };
};
