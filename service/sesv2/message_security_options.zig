const SigningScheme = @import("signing_scheme.zig").SigningScheme;

/// An object that defines the message-level security options that apply to
/// messages that
/// you send using the configuration set. Currently, these options determine
/// whether Amazon SES API v2
/// adds an S/MIME signature to your messages and, if so, the format of that
/// signature.
pub const MessageSecurityOptions = struct {
    /// The signing scheme that Amazon SES API v2 applies to messages sent with the
    /// configuration
    /// set.
    signing_scheme: ?SigningScheme = null,

    pub const json_field_names = .{
        .signing_scheme = "SigningScheme",
    };
};
