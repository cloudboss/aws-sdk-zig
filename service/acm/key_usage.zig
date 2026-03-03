const KeyUsageName = @import("key_usage_name.zig").KeyUsageName;

/// The Key Usage X.509 v3 extension defines the purpose of the public key
/// contained in the certificate.
pub const KeyUsage = struct {
    /// A string value that contains a Key Usage extension name.
    name: ?KeyUsageName = null,

    pub const json_field_names = .{
        .name = "Name",
    };
};
