const ApplicationPolicies = @import("application_policies.zig").ApplicationPolicies;
const KeyUsage = @import("key_usage.zig").KeyUsage;

/// Certificate extensions for v4 template schema
pub const ExtensionsV4 = struct {
    /// Application policies specify what the certificate is used for and its
    /// purpose.
    application_policies: ?ApplicationPolicies = null,

    /// The key usage extension defines the purpose (e.g., encipherment, signature)
    /// of the key
    /// contained in the certificate.
    key_usage: KeyUsage,

    pub const json_field_names = .{
        .application_policies = "ApplicationPolicies",
        .key_usage = "KeyUsage",
    };
};
