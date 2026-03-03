const KeyUsageFlags = @import("key_usage_flags.zig").KeyUsageFlags;

/// The key usage extension defines the purpose (e.g., encipherment, signature)
/// of the key
/// contained in the certificate.
pub const KeyUsage = struct {
    /// Sets the key usage extension to critical.
    critical: ?bool = null,

    /// The key usage flags represent the purpose (e.g., encipherment, signature) of
    /// the key
    /// contained in the certificate.
    usage_flags: KeyUsageFlags,

    pub const json_field_names = .{
        .critical = "Critical",
        .usage_flags = "UsageFlags",
    };
};
