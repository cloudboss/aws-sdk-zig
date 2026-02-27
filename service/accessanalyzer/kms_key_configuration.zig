const aws = @import("aws");

const KmsGrantConfiguration = @import("kms_grant_configuration.zig").KmsGrantConfiguration;

/// Proposed access control configuration for a KMS key. You can propose a
/// configuration for a new KMS key or an existing KMS key that you own by
/// specifying the key policy and KMS grant configuration. If the configuration
/// is for an existing key and you do not specify the key policy, the access
/// preview uses the existing policy for the key. If the access preview is for a
/// new resource and you do not specify the key policy, then the access preview
/// uses the default key policy. The proposed key policy cannot be an empty
/// string. For more information, see [Default key
/// policy](https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html#key-policy-default). For more information about key policy limits, see [Resource quotas](https://docs.aws.amazon.com/kms/latest/developerguide/resource-limits.html).
pub const KmsKeyConfiguration = struct {
    /// A list of proposed grant configurations for the KMS key. If the proposed
    /// grant configuration is for an existing key, the access preview uses the
    /// proposed list of grant configurations in place of the existing grants.
    /// Otherwise, the access preview uses the existing grants for the key.
    grants: ?[]const KmsGrantConfiguration,

    /// Resource policy configuration for the KMS key. The only valid value for the
    /// name of the key policy is `default`. For more information, see [Default key
    /// policy](https://docs.aws.amazon.com/kms/latest/developerguide/key-policies.html#key-policy-default).
    key_policies: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .grants = "grants",
        .key_policies = "keyPolicies",
    };
};
