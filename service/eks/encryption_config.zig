const Provider = @import("provider.zig").Provider;

/// The encryption configuration for the cluster.
pub const EncryptionConfig = struct {
    /// Key Management Service (KMS) key. Either the ARN or the alias can be used.
    provider: ?Provider = null,

    /// Specifies the resources to be encrypted. The only supported value is
    /// `secrets`.
    resources: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .provider = "provider",
        .resources = "resources",
    };
};
