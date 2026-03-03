/// The proposed access control configuration for an IAM role. You can propose a
/// configuration for a new IAM role or an existing IAM role that you own by
/// specifying the trust policy. If the configuration is for a new IAM role, you
/// must specify the trust policy. If the configuration is for an existing IAM
/// role that you own and you do not propose the trust policy, the access
/// preview uses the existing trust policy for the role. The proposed trust
/// policy cannot be an empty string. For more information about role trust
/// policy limits, see [IAM and STS
/// quotas](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html).
pub const IamRoleConfiguration = struct {
    /// The proposed trust policy for the IAM role.
    trust_policy: ?[]const u8 = null,

    pub const json_field_names = .{
        .trust_policy = "trustPolicy",
    };
};
