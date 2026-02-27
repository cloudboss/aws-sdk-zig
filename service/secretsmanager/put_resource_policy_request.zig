pub const PutResourcePolicyRequest = struct {
    /// Specifies whether to block resource-based policies that allow broad access
    /// to the
    /// secret, for example those that use a wildcard for the principal. By default,
    /// public
    /// policies aren't blocked.
    ///
    /// Resource policy validation and the BlockPublicPolicy parameter help protect
    /// your
    /// resources by preventing public access from being granted through the
    /// resource
    /// policies that are directly attached to your secrets. In addition to using
    /// these
    /// features, carefully inspect the following policies to confirm that they do
    /// not grant
    /// public access:
    ///
    /// * Identity-based policies attached to associated Amazon Web Services
    /// principals (for example, IAM roles)
    ///
    /// * Resource-based policies attached to associated Amazon Web Services
    /// resources (for example, Key Management Service (KMS)
    /// keys)
    ///
    /// To review permissions to your secrets, see [Determine who has permissions to
    /// your
    /// secrets](https://docs.aws.amazon.com/secretsmanager/latest/userguide/determine-acccess_examine-iam-policies.html).
    block_public_policy: ?bool,

    /// A JSON-formatted string for an Amazon Web Services resource-based policy.
    /// For example policies, see
    /// [Permissions policy
    /// examples](https://docs.aws.amazon.com/secretsmanager/latest/userguide/auth-and-access_examples.html).
    resource_policy: []const u8,

    /// The ARN or name of the secret to attach the resource-based policy.
    ///
    /// For an ARN, we recommend that you specify a complete ARN rather
    /// than a partial ARN. See [Finding a secret from a partial
    /// ARN](https://docs.aws.amazon.com/secretsmanager/latest/userguide/troubleshoot.html#ARN_secretnamehyphen).
    secret_id: []const u8,

    pub const json_field_names = .{
        .block_public_policy = "BlockPublicPolicy",
        .resource_policy = "ResourcePolicy",
        .secret_id = "SecretId",
    };
};
