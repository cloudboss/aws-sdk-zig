const ServerSideEncryptionRule = @import("server_side_encryption_rule.zig").ServerSideEncryptionRule;

/// Specifies the default server-side-encryption configuration.
pub const ServerSideEncryptionConfiguration = struct {
    /// Container for information about a particular server-side encryption
    /// configuration rule.
    rules: []const ServerSideEncryptionRule,
};
