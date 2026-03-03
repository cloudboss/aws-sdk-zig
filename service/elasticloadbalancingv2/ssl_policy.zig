const Cipher = @import("cipher.zig").Cipher;

/// Information about a policy used for SSL negotiation.
pub const SslPolicy = struct {
    /// The ciphers.
    ciphers: ?[]const Cipher = null,

    /// The name of the policy.
    name: ?[]const u8 = null,

    /// The protocols.
    ssl_protocols: ?[]const []const u8 = null,

    /// The supported load balancers.
    supported_load_balancer_types: ?[]const []const u8 = null,
};
