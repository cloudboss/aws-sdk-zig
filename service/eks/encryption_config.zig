const Provider = @import("provider.zig").Provider;

/// The encryption configuration for the cluster.
pub const EncryptionConfig = struct {
    /// Key Management Service (KMS) key. Either the ARN or the alias can be used.
    provider: ?Provider = null,

    /// Amazon EKS encrypts all Kubernetes API data with envelope encryption by
    /// default for
    /// clusters running Kubernetes version 1.28 or higher, so this field no longer
    /// affects which
    /// resources are encrypted.
    ///
    /// Specifies the resources to be encrypted. The only supported value is
    /// `secrets`.
    resources: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .provider = "provider",
        .resources = "resources",
    };
};
