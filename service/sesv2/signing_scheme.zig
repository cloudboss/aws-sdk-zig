const DefaultSigningScheme = @import("default_signing_scheme.zig").DefaultSigningScheme;
const SmimeSigningScheme = @import("smime_signing_scheme.zig").SmimeSigningScheme;

/// Specifies the signing scheme to apply to messages sent with a configuration
/// set. This
/// is a union type, so you specify exactly one of its members.
pub const SigningScheme = union(enum) {
    /// Use the default signing behavior. When you select this option, Amazon SES
    /// API v2 doesn't add an
    /// S/MIME signature to messages sent with the configuration set.
    default_scheme: ?DefaultSigningScheme,
    /// Sign messages sent with the configuration set using S/MIME. For signing to
    /// apply, the
    /// email identity used to send a message must have an active S/MIME certificate
    /// association.
    smime_scheme: ?SmimeSigningScheme,

    pub const json_field_names = .{
        .default_scheme = "DefaultScheme",
        .smime_scheme = "SmimeScheme",
    };
};
